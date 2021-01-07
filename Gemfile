source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.1.0'

gem 'pg', '= 1.1.4'
gem 'activerecord-postgresql-adapter'

# Use Puma as the app server
gem 'puma', '~> 5.0'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 5.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Active Model has_secure_password
gem 'bcrypt', '~> 3.1.7'

gem 'thwait' # a bug in Ruby 2.7 - it's not bundled by default

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

gem 'dotenv-rails' # and dotenv for env-load
gem 'foreman', require: false

# SideKiq & SideKiq Admin
gem 'sinatra', require: false
gem 'sidekiq', '~> 5'
gem 'sidekiq-scheduler', '~> 2'
gem 'sidekiq-unique-jobs'
gem 'hiredis'
gem 'connection_pool'

# ActiveAdmin
gem 'activeadmin'
gem 'devise'



# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]

  # Better IRB
  gem 'pry-rails'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.1.0'
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'

  gem 'm', '~> 1.5.0'
  gem 'timecop'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Helper tools: https://github.com/info-sig/infosig-utils,
# to use local version see: https://bundler.io/v1.12/git.html#local-git-repos
gem 'infosig-utils', git: 'https://github.com/info-sig/infosig-utils', branch: 'master'

# HTTP
gem 'faraday'
