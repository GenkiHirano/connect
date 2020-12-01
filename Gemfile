source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.6'

gem 'rails', '~> 6.0.3', '>= 6.0.3.3'
gem 'bcrypt'
gem 'puma',       '~> 4.1'
gem 'sass-rails', '>= 6'
gem 'webpacker',  '~> 4.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder',   '~> 2.7'
gem 'bootsnap',    '>= 1.4.2', require: false
gem 'bootstrap-sass'
gem 'devise'
gem 'faker'
gem 'jquery-rails'
gem 'will_paginate'
gem 'bootstrap-will_paginate'

group :development, :test do
  gem "factory_bot_rails"
  gem 'rubocop-airbnb'
  gem 'rails-controller-testing'
  gem 'rspec-rails'
  gem 'sqlite3'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'spring-commands-rspec'
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'webdrivers'
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
end

group :production do
  gem 'pg'
end

gem 'tzinfo-data'
