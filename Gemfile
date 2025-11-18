source "https://rubygems.org"

# Ruby on Rails
gem "bootsnap", require: false
gem "image_processing", "~> 1.2"
gem "importmap-rails"
gem "jbuilder"
gem "kamal", require: false
gem "propshaft"
gem "puma", ">= 5.0"
gem "rails", "~> 8.1.1"
gem "solid_cable"
gem "solid_cache"
gem "solid_queue"
gem "stimulus-rails"
gem "thruster", require: false
gem "turbo-rails"
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Additional
gem "dotenv-rails"
gem "pg"

# Conditional
group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "bundler-audit", require: false
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end