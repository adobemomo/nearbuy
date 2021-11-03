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

gem 'bootstrap', '~> 5.1'
gem 'devise', '~> 4.7'

source 'https://rails-assets.org' do
  gem 'rails-assets-underscore'
end

group :development, :test do
  gem 'rspec', '~> 3.10'
  gem 'rspec-rails', '~> 4.0', '>= 4.0.2'
  gem 'simplecov', '~> 0.20.0'
  gem 'sqlite3', '~> 1.3.11'
end

group :production do
  gem 'pg', '~> 0.15' # for Heroku deployment
  gem 'rails_12factor'
end
