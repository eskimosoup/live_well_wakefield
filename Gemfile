# frozen_string_literal: true

source 'https://rubygems.org'

gem 'coffee-rails', '~> 4.1.0'
gem 'friendly_id', '~> 5.1.0'
gem 'jbuilder', '~> 2.0'
gem 'jquery-rails', '4.0.5'
gem 'optimadmin', git: 'git@github.com:eskimosoup/Optimadmin.git', branch: 'master'
gem 'pg', '0.15'
gem 'rails', '~> 4.2'
gem 'recaptcha', require: 'recaptcha/rails'
gem 'sassc-rails'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'therubyracer', platforms: :ruby
gem 'uglifier', '>= 1.3.0'

group :development, :test do
  gem 'byebug'
  gem 'dotenv-rails'
  gem 'factory_girl_rails', '~> 4.5.0'
  gem 'rspec-rails', '~> 3.0'
  gem 'shoulda-callback-matchers'
  gem 'shoulda-matchers', '~> 2.8.0'
end

group :development do
  gem 'bullet', '~> 4.14.7'
  gem 'flamegraph', '~> 0.1.0'
  gem 'guard-rspec', '~> 4.6.4', require: false
  gem 'optimadmin_generators', git: 'git@github.com:eskimosoup/optimadmin_generators.git'
  gem 'quiet_assets', '~> 1.1.0'
  gem 'rack-mini-profiler', '~> 0.9.7'
  gem 'spring'
  gem 'stackprof', '~> 0.2.7'
  gem 'thin'
  gem 'web-console', '~> 2.0'
  gem 'letter_opener'
end

group :test do
  gem 'capybara', '~> 2.5.0'
  gem 'database_cleaner', '~> 1.5.0'
  gem 'launchy', '~> 2.4.3'
  gem 'poltergeist', '~> 1.6.0'
end

source 'https://rails-assets.org' do
  gem 'rails-assets-matchHeight'
  gem 'rails-assets-slick.js'
end

group :development do
  gem 'capistrano', require: false
  gem 'capistrano-rails', require: false
  gem 'capistrano-rbenv', require: false
  gem 'capistrano-passenger', require: false
end
