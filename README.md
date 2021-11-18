### Members
  - Chaofan Wang, cw3288
  - Rong Bai, rb3512
  - Jiawei Wang, jw4156
  - Sheng Jiang, sj3129

### Github
  https://github.com/adobemomo/nearbuy

### Version Prequisite
  `ruby 2.6.6`
  `bundle 2.2.28`
  `gem 3.0.9`
### Deployment instructions
  - heroku app link: https://mysterious-oasis-25704.herokuapp.com/
  - run `bundle`
  - run `git remote add heroku https://git.heroku.com/mysterious-oasis-25704.git`
  - run `git push heroku <your_brunch_name>:main` to see your change on heroku
  - run `heroku run rails db:migrate` to update database
  - run `heroku run rails db:seed` to add init data

### Run in local
  - `bundle install` to install required gem
  - `rails db:migrate` to setup db schema
  - `rails s` to run application locally
  - Google Map service may not available in local mode.

### Rspec Test
  - `bundle install` to install required gem
  - `rails db:migrate RAILS_ENV=test` to setup db in test environment
  - `rails spec` to run Rspec test
  - coverage files are generated in folder coverage

### Cucumber Test
  - `bundle install` to install required gem
  - `rails db:migrate RAILS_ENV=test` to setup db in test environment
  - `rails cucumber` to run Cucumber
  - coverage files are generated in folder coverage

### Features
  - User can add, edit and delete goods
  - Goods posted will show up on google map module
  - Click pins on google map, goods info will show up
  - User can sign up and sign in

### Coverage
  Since Cucumber is basically for testing the controller, and RSpec is for models and database, the coverage for these two tests has no need to be overlapped. So the coverage for each might not be high (i.e. close to 100%). However, the overall test coverage is near 100%.
