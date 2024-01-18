# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem 'dotenv-rails', '~> 2.8.1', groups: %i[development test], require: 'dotenv/rails-now'
ruby '3.1.2'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.0.8'

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem 'sprockets-rails', '~> 3.4.2'

# Use mysql as the database for Active Record
gem 'mysql2', '~> 0.5.5'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '~> 5.6.7'

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem 'importmap-rails', '~> 1.2.1'

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem 'turbo-rails', '~> 1.4.0'

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem 'stimulus-rails', '~> 1.2.2'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem 'jbuilder', '~> 2.11.5'

gem 'hiredis', '~> 0.6.3'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 5.0.7', require: %w[redis hiredis]

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '~> 1.16.0', require: false

# Use Sass to process CSS
gem 'sassc-rails', '~> 2.1.2'

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem 'image_processing', '~> 1.2'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', '~> 1.8.0', platforms: %i[mri mingw x64_mingw]
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'pry'
  gem 'web-console', '~> 4.2.1'

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
  gem 'annotate', '~> 3.2.0'
  gem 'faker', '~> 3.2.1'
  gem 'letter_opener_web', '~> 2.0.0'
  gem 'rubocop-rails', '~> 2.21.1'
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem 'capybara', '~> 3.39.2'
  gem 'selenium-webdriver', '~> 4.13.1'
end

gem 'acts_as_hashids', '~> 0.2.0'
gem 'bootstrap', '~> 5.3.1'
gem 'bootstrap5-kaminari-views', '~> 0.0.1'
gem 'carrierwave', '~> 3.0.3'
gem 'devise', '~> 4.9.2'
gem 'fog-aws', '~> 3.20.0'
gem 'font-awesome-sass', '~> 6.4.2'
gem 'inline_svg', '~> 1.7', '>= 1.7.2'
gem 'jquery-rails', '~> 4.6.0'
gem 'kaminari', '~> 1.2.2'
gem 'mini_magick', '~> 4.12.0'
gem 'paranoia', '~> 2.6.2'
gem 'pundit', '~> 2.3.1'
gem 'rails-i18n', '~> 7.0.8'
gem 'ransack', '~> 4.0.0'
gem 'requestjs-rails', '~> 0.0.10'
gem 'sidekiq', '~> 7.1.4'
gem 'whenever', '~> 1.0.0'
gem 'streamio-ffmpeg', '~> 3.0', '>= 3.0.2'