source "https://rubygems.org"
git_source(:github){|repo| "https://github.com/#{repo}.git"}

ruby "3.2.2"
gem "active_storage_validations", "0.9.8"
gem "bcrypt", "3.1.18"
gem "byebug"
gem "config"
gem "dotenv-rails"
gem "faker"
gem "i18n-js", "~>3.9.2"
gem "image_processing", "1.12.2"
gem "importmap-rails"
gem "mysql2", "~> 0.5"
gem "pagy"
gem "puma", "~> 5.0"
gem "rails", "~> 7.0.5"
gem "rails-i18n"
gem "sprockets-rails"
gem "stimulus-rails"
gem "turbo-rails"
# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Use Redis adapter to run Action Cable in production
# gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i(mingw mswin x64_mingw jruby)

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false
gem "bootstrap-sass", "3.4.1"

# Use Sass to process CSS
# gem "sassc-rails"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html]
# gem "image_processing", "~> 1.2"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html
  gem "debug", platforms: %i(mri mingw x64_mingw)
  gem "rubocop", "~> 1.26", require: false
  gem "rubocop-checkstyle_formatter", require: false
  gem "rubocop-rails", "~> 2.14.0", require: false
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html]
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end
