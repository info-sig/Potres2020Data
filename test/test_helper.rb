require 'sidekiq/testing'

ENV['RAILS_ENV'] ||= 'test'
require_relative "../config/environment"
require "rails/test_help"

raise "don't want to run tests if DATABASE_URL is set, I'm scared to drop a production database" if ENV['DATABASE_URL']

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)
  # Add more helper methods to be used by all tests here...

  def setup
    TestableSecureRandom.make_random!
    Sidekiq::Testing.fake!
    $faked_api_exchange ||= []
  end

  def teardown
    Sidekiq::Worker.clear_all
    Timecop.return
    if $faked_api_exchange&.any?
      flunked_api_exchanges = $faked_api_exchange.clone
      $faked_api_exchange = nil
      flunk("following api exchanges are still in queue for #{@NAME}: #{flunked_api_exchanges}")
    end
  end

end
