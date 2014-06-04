# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Video.create(
  category: Category.find_by(name: "Comedy"),
  title: "Family Guy",
  description: "It's the family GUYYYYYYYY!",
  small_cover_url: "/tmp/family_guy.jpg",
  large_cover_url: "/tmp/monk_large.jpg")

Video.create(
  category: Category.find_by(name: "Drama"),
  title: "Futurama",
  description: "Fry wakes up in the future to many adventures",
  small_cover_url: "/tmp/futurama.jpg",
  large_cover_url: "/tmp/monk_large.jpg")

Video.create(
  category: Category.find_by(name: "Western"),
  title: "Monk",
  description: "Silly OCD PI and his neurotic misadventures.",
  small_cover_url: "/tmp/monk.jpg",
  large_cover_url: "/tmp/monk_large.jpg")

Video.create(
  category: Category.find_by(name: "Comedy"),
  title: "South Park",
  description: "Miscirent young boys wild in Colorado.",
  small_cover_url: "/tmp/south_park.jpg",
  large_cover_url: "/tmp/monk_large.jpg")
  

Category.create(name: "Comedy")
Category.create(name: "Drama")
Category.create(name: "Western")