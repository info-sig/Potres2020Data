require 'sidekiq/testing'

ENV['RAILS_ENV'] ||= 'test'
require_relative "../config/environment"
require "rails/test_help"

raise "don't want to run tests if DATABASE_URL is set, I'm scared to drop a production database" if ENV['DATABASE_URL']

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  # parallelize(workers: :number_of_processors)
  # Add more helper methods to be used by all tests here...

  def setup
    TestableSecureRandom.make_random!
    Sidekiq::Testing.fake!
    $faked_api_exchange ||= []

    # ActiveRecord::Base.connection.reset_pk_sequence!('cases') # NOT A SEQUENCE!
    # ActiveRecord::Base.connection.reset_pk_sequence!('foreign_cases')
    ActiveRecord::Base.connection.execute('alter sequence ticket_version_seq restart;')
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

  def api_exchange
    $faked_api_exchange
  end

  def api_exchange= arg
    $faked_api_exchange = arg
  end

  def assert_equal_or_nil exp, act, msg = 'is bonky'
    if exp
      assert_equal exp, act, msg
    else
      assert_nil act, msg
    end
  end

  def assert_equal_hashes exp, act, message = "false should be truthy", options = {}
    except = options.delete(:except) || []
    except = [except] unless except.is_a?(Array)

    exp = exp.with_indifferent_access.except(*except) if exp.is_a?(Hash)
    act = act.with_indifferent_access.except(*except) if act.is_a?(Hash)

    if exp == act
      assert true, "#{message}:  YAAAY ! you da man you beautiful!"
      return
    end

    subtract = lambda{|a,b| a.slice(*(a.keys-b.keys))}

    act_exp = subtract[act, exp]
    flunk "#{message}: actual hash has some extra keys\n\nextra keys: #{act_exp}\n\nEXP: #{exp}\nACT: #{act}" if act_exp.any?

    exp_act = subtract[exp, act]
    flunk "#{message}: expected hash has some extra keys\n\nextra keys: #{exp_act}\n\nEXP: #{exp}\nACT: #{act}" if exp_act.any?

    diffing_keys = exp.filter{|k,v| act[k] != v}.keys
    exp_diffing_els = exp.slice(*diffing_keys)
    act_diffing_els = act.slice(*diffing_keys)
    flunk "#{message}: some elements differ\n\nUnexpected elements:\n  EXP (part): #{exp_diffing_els}\n  ACT (part): #{act_diffing_els}\n\nFull hashes:\n  EXP: #{exp}\n  ACT: #{act}"

    # let's binding.pry this thing if it happens, but not on travis
    nondeterministic_fail{ flunk }
  end

  def assert_equal_arrays exps, acts, messages = "false should be truthy", options = {}
    if exps == acts
      assert true, "#{messages}:  YAAAY ! you da man you beautiful!"
      return
    end

    exps_iterator = exps.clone
    acts_iterator = acts.clone

    idx = 0
    begin
      exp, act = exps_iterator.shift, acts_iterator.shift
      message_el = "#{messages} idx #{idx}"

      if exp.is_a?(Hash) && act.is_a?(Hash)
        assert_equal_hashes exp, act, "#{message_el}\n\nEXP: #{exps}\nACT: #{acts}", options
      else
        assert_equal_or_nil exp, act, "#{message_el}\n\nEXP: #{exps}\nACT: #{acts}"
      end

      idx += 1
    end while exps_iterator.present? && acts_iterator.present?

    assert exps_iterator.empty?, "#{messages}: expectations array contains more elements, a trailing element is missing: #{exps_iterator}\n\nEXP: #{exps}\nACT: #{acts}"
    assert acts_iterator.empty?, "#{messages}: actual array contains more elements, a trailing element is extra: #{acts_iterator}\n\nEXP: #{exps}\nACT: #{acts}"
  end

end
