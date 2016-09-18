source 'https://rubygems.org'

gem 'rails', '~> 5.0.0', '>= 5.0.0.1'
gem 'pg'
gem 'puma', '~> 3.0'
gem 'rack-cors', :require => 'rack/cors'

gem 'devise'
gem 'omniauth-facebook'
gem 'tiddle'
gem 'acts_as_list'
gem 'active_model_serializers'

# File uploader
gem 'carrierwave'
gem 'mini_magick'

group :development do
  gem 'listen'
  gem 'awesome_pry'
  gem 'better_errors'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'sqlite3'

  # RSpec
  gem 'rspec-rails'
  gem 'airborne' # api  testing
  gem 'shoulda-matchers'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'database_cleaner'
  gem 'fuubar', require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
