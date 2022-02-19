source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.3', '>= 6.0.3.4'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 4.1'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 4.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
gem 'image_processing', '~> 1.2'

gem 'bootstrap_form', '~> 4.5'

gem 'bootstrap', '~> 4.5', '>= 4.5.2'

gem 'devise', '~> 4.7', '>= 4.7.3'

gem 'omniauth-facebook', '~> 8.0'

gem 'omniauth', '~> 1.9', '>= 1.9.1'

gem 'font-awesome-rails', '~> 4.7', '>= 4.7.0.5'

gem 'acts_as_favoritor', '~> 5.0'

gem 'figaro', '~> 1.2'

gem 'jquery-rails', '~> 4.4'

gem "aws-sdk-s3", require: false

gem 'active_storage_validations', '~> 0.9.0'

gem 'activerecord-session_store', '~> 1.1', '>= 1.1.3'
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails', '~> 6.1'
  gem 'faker', '~> 2.14'
  gem 'rails-controller-testing', '~> 1.0', '>= 1.0.5'
  gem 'rspec-rails', '~> 4.0', '>= 4.0.1'
  gem 'shoulda-matchers', '~> 4.4', '>= 4.4.1'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'letter_opener', '~> 1.7'
  gem 'letter_opener_web', '~> 1.4'
  gem 'listen', '~> 3.2'
  gem 'web-console', '>= 3.3.0'
  gem 'bullet', '~> 6.1'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
