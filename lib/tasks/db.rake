namespace :db do

  namespace :backend do
    task :install => :environment do
      log_and_go{ ActiveRecord::Base.connection.execute('CREATE SEQUENCE ticket_version_seq START 10000;') }
    end
  end

  namespace :test do
    desc "set up test databases"
    task :setup do
      base_db_url = 'postgres://test:test@127.0.0.1:5432/infoswitch_test'

      setup_db = lambda do |db_url|
        # ENV['DATABASE_URL'] = db_url
        puts "="*80
        puts "              #{db_url}"
        puts "="*80
        system({"RAILS_ENV" => 'test', "DATABASE_URL" => db_url}, "bin/rails db:environment:set; rake db:schema:load")
      end

      futures = []
      futures << Concurrent::Future.execute{ setup_db[base_db_url] }
      4.times do |x|
        futures << Concurrent::Future.execute{ setup_db[base_db_url + "_#{x+1}"] }
      end

      futures.each(&:value)
    end
  end

end

def log_and_go
  yield
rescue ActiveRecord::StatementInvalid => e
  puts "Warning: #{e.class} #{e.message}".gsub("\n", ' ')
  nil
end
