# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.destroy_all
User.create(email: "sjiang@gmail.com", address: "nyc", first_name: "aa", last_name: "bb", username: "lol", password: "123456", password_confirmation: "123456")
User.create(email: "john@gmail.com", address: "boston", first_name: "zq", last_name: "hu", username: "hzq", password: "123456", password_confirmation: "123456")

Goods.destroy_all
Goods.create(name: "Apple Watch", address: "1047 Amsterdam Ave, New York, NY 10025", user_name: "lol", description: "apple watch series 7, 99% new", address1: "1048 Amsterdam Ave, New York, NY 10025", address2: "1049 Amsterdam Ave, New York, NY 10025")
Goods.create(name: "Textbooks", address: "2389 Broadway, New York, NY 10024", user_name: "lol", description: "Calculus")
Goods.create(name: "Desktop table", address: "2393 Broadway, New York, NY 10024", user_name: "lol", description: "good")
Goods.create(name: "nintendo switch", address: "2396 Broadway, New York, NY 10024", user_name: "lol", description: "cool")
Goods.create(name: "chair", address: "2400 Broadway, New York, NY 10024", user_name: "lol", description: "great")
Goods.create(name: "pot", address: "2404 Broadway, New York, NY 10024", user_name: "lol", description: "excellent")
