# frozen_string_literal: true

source "https://rubygems.org"

ruby "2.3.3"

gem "rails", "~> 5.0"

gem "pg", "~> 0.18"

gem "puma", "~> 3.0"

gem "sass-rails"
gem "bootstrap-sass"

gem "uglifier"
gem "jquery-rails"

gem "turbolinks"

gem "omniauth"
gem "omniauth-github"

group :test do
  gem "rspec-rails"
  gem "factory_girl_rails"
  gem "shoulda-matchers", require: false
end

group :development, :test do
  gem "dotenv-rails"
end

group :development do
  gem "rubocop"
  gem "rubocop-rspec"
  gem "web-console"
  gem "spring"
end
