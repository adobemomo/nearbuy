### Version Prequisite
  `ruby 2.6.6`
  `bundle 2.2.28`
  `gem 3.0.9`
### Deployment instructions
  - heroku app link: https://mysterious-oasis-25704.herokuapp.com/
  - run `bundle`
  - run `git push heroku <your_brunch_name>:main` to see your change on heroku
  - run `heroku run rails db:migrate` to update database

### Run in local
  - `bundle install` to install required gem
  - `rails db:migrate` to setup db schema
  - `rails s` to run application locally
  - Google Map service may not available in local mode.
