# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts "Cleaning database..."
Booking.destroy_all
Room.destroy_all
User.destroy_all

puts "Database cleaned!"

puts "Creating 2 admin users..."

User.create(
  email: "erle22@hotmail.fr",
  password: "password",
  first_name: "Erle",
  last_name: "Le Bris",
  admin: true
)

User.create(
  email: "emilie.aubry59@gmail.com",
  password: "password",
  first_name: "Emilie",
  last_name: "Aubry",
  admin: true
)
