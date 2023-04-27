# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts "Cleaning database..."
Review.destroy_all
Booking.destroy_all

### Comment 3 next lines after first time in production
RoomPrice.destroy_all
Room.destroy_all
User.destroy_all

puts "Database cleaned!"

## Comment next lines after first time in production

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

puts "2 admin users created!"

puts "Creating 2 normal users..."

User.create(
  email: "coco@me.com",
  password: "password",
  first_name: "Corentin",
  last_name: "Le Bris",
  admin: false
)

User.create(
  email: "gwen@me.com",
  password: "password",
  first_name: "Gwendal",
  last_name: "Le Bris",
  admin: false
)

puts "2 normal users created!"

puts "Creating 2 rooms..."

description_maison = "En séjournant dans notre maison, vous pourrez profiter d'un cadre de vie chaleureux et convivial, avec une décoration soignée qui reflète notre personnalité et notre style de vie. Notre maison est équipée de tout ce dont vous aurez besoin pour passer un séjour confortable, notamment une cuisine entièrement équipée, une salle de bains moderne et des chambres confortables."

maison = Room.create(
  name: "La Maison",
  description: description_maison,
  max_guests: 8,
  arrival_hour: "à partir de 14:00",
  departure_hour: "avant 12:00",
  bedrooms: 3,
  beds: 3,
  bathrooms: 2
)

description_chambre = "Nous proposons une chambre confortable, lumineuse et climatisée, équipée d'un lit Queen size et d'une commode pour ranger vos effets personnels. Vous aurez également accès au reste des parties communes partagées avec nous."

chambre = Room.create(
  name: "La Chambre",
  description: description_chambre,
  max_guests: 2,
  arrival_hour: "entre 18:00 et 22:00",
  departure_hour: "avant 11:00",
  bedrooms: 1,
  beds: 1,
  bathrooms: 1
)

puts "2 rooms created!"

puts "Creating 2 room prices..."

RoomPrice.create(
  room: maison,
  night_price: 160,
  night_price_seven_guests: 170,
  night_price_eight_guests: 180,
  week_reduction: -32,
  cleaning_fee: 60
)

RoomPrice.create(
  room: chambre,
  night_price: 40,
  week_reduction: -6,
  cleaning_fee: 0
)

puts "2 room prices created!"

### Finsih commenting lines after first time in production

coco = User.find_by(first_name: "Corentin")
gwen = User.find_by(first_name: "Gwendal")
maison = Room.find_by(name: "La Maison")
chambre = Room.find_by(name: "La Chambre")

puts "Creating 8 bookings..."

booking1 = Booking.create(
  user: coco,
  room: maison,
  arrival: DateTime.new(2023, 5, 1, 14, 0, 0),
  departure: DateTime.new(2023, 5, 13, 12, 0, 0),
  guests_number: 4,
  status: "acceptée"
)

booking2 = Booking.create(
  user: gwen,
  room: maison,
  arrival: DateTime.new(2023, 5, 21, 14, 0, 0),
  departure: DateTime.new(2023, 6, 9, 12, 0, 0),
  guests_number: 8,
  status: "acceptée"
)

booking3 = Booking.create(
  user: coco,
  room: chambre,
  arrival: DateTime.new(2023, 4, 25, 18, 0, 0),
  departure: DateTime.new(2023, 5, 1, 11, 0, 0),
  guests_number: 2,
  status: "acceptée"
)

booking4 = Booking.create(
  user: gwen,
  room: chambre,
  arrival: DateTime.new(2023, 5, 5, 18, 0, 0),
  departure: DateTime.new(2023, 5, 9, 11, 0, 0),
  guests_number: 1,
  status: "acceptée"
)

booking5 = Booking.create(
  user: coco,
  room: chambre,
  arrival: DateTime.new(2023, 5, 12, 18, 0, 0),
  departure: DateTime.new(2023, 5, 22, 11, 0, 0),
  guests_number: 2,
  status: "en attente"
)

booking6 = Booking.create(
  user: gwen,
  room: chambre,
  arrival: DateTime.new(2023, 5, 26, 18, 0, 0),
  departure: DateTime.new(2023, 5, 29, 11, 0, 0),
  guests_number: 1,
  status: "en attente"
)

booking7 = Booking.create(
  user: gwen,
  room: chambre,
  arrival: DateTime.new(2023, 5, 26, 18, 0, 0),
  departure: DateTime.new(2023, 5, 29, 11, 0, 0),
  guests_number: 1,
  status: "refusée"
)

booking8 = Booking.create(
  user: gwen,
  room: chambre,
  arrival: DateTime.new(2023, 2, 20, 18, 0, 0),
  departure: DateTime.new(2023, 2, 22, 11, 0, 0),
  guests_number: 1,
  status: "acceptée"
)

puts "8 bookings created!"

puts "Creating reviews..."

author1 = "Claude - décembre 2022"
content1 = "Très bon séjour dans cette maison. On a trouvé la maison plus belle en vrai qu'en photos.
Nous y avons passé un très bon Noël en famille.
Maison très propre, et principe de la clé électronique très pratique.
Merci aussi pour la petite attention à notre arrivée.
À recommander pour les familles nombreuses !"
Review.create(author: author1, content: content1, room_id: maison.id)

author2 = "Audrey - octobre 2022"
content2 = "Maison magnifique, décorée avec goût, spacieuse et à deux pas de Toulouse. Les photos ne lui rendent pas justice : elle est encore plus jolie en vrai !
La literie est de grande qualité, du matelas jusqu'aux coussins. Tout est super bien expliqué : le fonctionnement de la porte d'entrée, des différents éléments de la cuisine...
Merci pour cette belle parenthèse dans notre weekend toulousain."
Review.create(author: author2, content: content2, room_id: maison.id)

author3 = "Elea - mai 2022"
content3 = "Le logement est fidèle à l'annonce, la communication est fluide et l'arrivée très bien organisée.
Si vous souhaitez passer un séjour sur Toulouse et loger dans un quartier calme et appairant je vous recommande vivement celui-ci.
De plus Émilie est très réactive en cas de besoin, pour toutes questions.
Ce fût un très bon séjour pour nous qui étions 7 avec tout le nécessaire à disposition."
Review.create(author: author3, content: content3, room_id: maison.id)

puts "Reviews created!"

puts "Finished!"
