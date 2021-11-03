source 'https://rubygems.org'

ruby '2.6.6'

gem 'puma'
gem 'rails', '5.0.5'

gem 'bootstrap-sass'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'sass-rails'
gem 'uglifier'

gem 'geocoder'
gem 'gmaps4rails'

source 'https://rails-assets.org' do
  gem 'rails-assets-underscore'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'sqlite3', '~> 1.3.11'
end

group :test do
  gem 'simplecov', :require => false
end

group :production do
  gem 'pg', '~> 0.15' # for Heroku deployment
  gem 'rails_12factor'
end