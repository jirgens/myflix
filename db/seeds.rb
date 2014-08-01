# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
comedy = Category.create(name: "Comedy")
drama = Category.create(name: "Drama")
western = Category.create(name: "Western")
  
Admin = User.create(full_name: "Myflix Admin", password: "password", email: "admin@myflix.com", admin: "true")
Aiden = User.create(full_name: "Aiden Quinn", password: "password", email: "me@myself.com")
