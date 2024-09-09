# frozen_string_literal: true

source "https://rubygems.org"

gem "bootsnap", require: false
gem "kaminari"
gem "pg", "~> 1.5"
gem "puma", ">= 5.0"
gem "rails", "~> 7.2.1"
gem "redis"
gem "scout_apm"
gem "sidekiq"
gem "sprockets-rails"
gem "tzinfo-data", platforms: %i[windows jruby]

# Graphql
gem "graphql", "~> 2.0"

group :development, :test do
  gem "byebug"
  gem "debug", platforms: %i[mri windows], require: "debug/prelude"
  gem "dotenv-rails"

  # Code Quality & Linting
  gem "rubocop", require: false
  # gem "rubocop-rails-omakase", require: false
  gem "rubocop-factory_bot", require: false
  gem "rubocop-faker", require: false
  gem "rubocop-migration", require: false
  gem "rubocop-performance", require: false
  gem "rubocop-rails", require: false
  gem "rubocop-rake", require: false
  gem "rubocop-rspec", require: false

  # Rspec
  gem "factory_bot_rails"
  gem "faker"
  gem "rspec-rails", "~> 7.0.0"

  # Security
  gem "brakeman", require: false
  gem "bundler-audit", require: false
end

group :development do
  # Performance
  gem "bullet"
end

group :test do
  gem "rspec-sidekiq"
  gem "shoulda-matchers"
  gem "simplecov", require: false
end
