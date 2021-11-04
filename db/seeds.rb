# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Goods.destroy_all
Goods.create(name: "Apple Watch", address: "1047 Amsterdam Ave, New York, NY 10025")
Goods.create(name: "Textbooks", address: "2389 Broadway, New York, NY 10024")
