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
  email: "erle@me.com",
  password: "password",
  first_name: "Erle",
  last_name: "Le Bris",
  admin: true
)

User.create(
  email: "emilie@me.com",
  password: "password",
  first_name: "Emilie",
  last_name: "Aubry",
  admin: true
)

puts "2 admin users created!"

puts "Creating 2 normal users..."

coco = User.create(
  email: "coco@me.com",
  password: "password",
  first_name: "Corentin",
  last_name: "Le Bris",
  admin: false
)

gwen = User.create(
  email: "gwen@me.com",
  password: "password",
  first_name: "Gwendal",
  last_name: "Le Bris",
  admin: false
)

puts "2 normal users created!"

puts "Creating 2 rooms..."

maison = Room.create(
  name: "La Maison",
  description: "Description 1",
  max_guests: 8,
  price_per_day: 75,
  arrival_hour: "à partir de 14:00",
  departure_hour: "avant 12:00",
  bedrooms: 3,
  beds: 3,
  bathrooms: 2
)

chambre = Room.create(
  name: "La Chambre",
  description: "Description 2",
  max_guests: 2,
  price_per_day: 25,
  arrival_hour: "entre 18:00 et 22:00",
  departure_hour: "avant 11:00",
  bedrooms: 1,
  beds: 1,
  bathrooms: 1,
)

puts "2 rooms created!"

puts "Creating 3 bookings..."

booking1 = Booking.new(
  user: coco,
  room: maison,
  start_date: DateTime.new(2023, 5, 5, 14, 0, 0),
  end_date: DateTime.new(2023, 5, 7, 11, 0, 0),
  guests_number: 4,
  status: "pending"
)
booking1.booking_price = booking1.calculate_booking_price
booking1.save

booking2 = Booking.new(
  user: coco,
  room: chambre,
  start_date: DateTime.new(2023, 5, 8, 14, 0, 0),
  end_date: DateTime.new(2023, 5, 9, 11, 0, 0),
  guests_number: 2,
  status: "pending"
)
booking2.booking_price = booking2.calculate_booking_price
booking2.save

booking3 = Booking.new(
  user: gwen,
  room: chambre,
  start_date: DateTime.new(2023, 5, 10, 14, 0, 0),
  end_date: DateTime.new(2023, 5, 12, 11, 0, 0),
  guests_number: 1,
  status: "approved"
)
booking3.booking_price = booking3.calculate_booking_price
booking3.save

puts "3 bookings created!"

Booking.all.each { |booking| p booking }

puts "Finished!"
