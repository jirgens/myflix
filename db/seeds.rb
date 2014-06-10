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

monk = Video.create(title: "Monk", description: "Silly OCD PI and his neurotic misadventures.", category: western, small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/monk_large.jpg")
  # category: Category.find_by(name: "Western"),
  # title: "Monk",
  # description: "Silly OCD PI and his neurotic misadventures.",
  # small_cover_url: "/tmp/monk.jpg",
  # large_cover_url: "/tmp/monk_large.jpg")

Video.create(title: "South Park", description: "Miscirent young boys wild in Colorado.", category: comedy, small_cover_url: "/tmp/south_park.jpg", large_cover_url: "/tmp/monk_large.jpg")
  # category: Category.find_by(name: "Comedy"),
  # title: "South Park",
  # description: "Miscirent young boys wild in Colorado.",
  # small_cover_url: "/tmp/south_park.jpg",
  # large_cover_url: "/tmp/monk_large.jpg")
  

Joss = User.create(full_name: "Joss Stone", password: "password", email: "joss@stone.com")

Review.create(user: Joss, video: monk, rating: 5, content: "This is the most awesome thing I've ever seen.")
Review.create(user: Joss, video: monk, rating: 2, content: "I really did not like this at all.")
