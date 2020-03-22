source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.12'
gem 'rails', '~> 5.2.3'
gem 'bcrypt', '~> 3.1.7'
# gem 'redis', '~> 4.0'
gem 'rack-cors'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false
gem 'nokogiri', ">= 1.10.4"

# API
gem 'knock'
gem 'fast_jsonapi'

# Documentation
gem 'rswag-api'
gem 'rswag-ui'

# Services
gem 'money-rails', '~> 1.12'
gem 'eu_central_bank'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'pry'
  gem 'pry-rails'
  gem 'rspec-rails'
  gem 'rubocop'
  gem 'rubocop-rails'
end

group :development do
  gem 'letter_opener'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'rswag-specs'
  gem 'shoulda-matchers'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
