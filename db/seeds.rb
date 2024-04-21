### Add to next production

puts "Creating contents..."

Content.create(
  name: "home_title",
  html: "Hébergements proches de Toulouse"
)

Content.create(
  name: "introduction_description",
  html: "Vous cherchez un hébergement <strong>confortable et convivial</strong> à Toulouse ?
  Découvrez notre maison complète ou nos chambres chez l'habitant situées à proximité immédiate de cette ville historique."
)

Content.create(
  name: "subtitle_home_title",
  html: "Que vous soyez en ville pour un voyage d'affaires, une escapade romantique ou simplement pour explorer la région, voici ce que nous proposons :"
)

Content.create(
  name: "subtitle_home_description",
  html:
    "- Soit, la maison entière privative située dans un quartier calme et verdoyant, avec jusque 8 couchages
    - Soit, les 2 chambres privatives situées dans ce logement partagé avec les propriétaires, avec 2 couchages chacune"
)

Content.create(
  name: "localisation_infos",
  html: "A proximité immédiate du <a href='https://www.domainedepreissac.fr/' class='text-blue text-decoration-none' target='_blank'>Domaine de Preissac</a> (moins de 2km en voiture et environ 15-20min à pied).
  <br></br><br></br>Quartier résidentiel à proximité immédiate du <a href='https://www.visorando.com/randonnee-lac-de-la-tuilerie-saint-jean.html' class='text-blue text-decoration-none' target='_blank'>Lac de la Tuilerie</a>."
)

Content.create(
  name: "moving_around",
  html: "Pour rejoindre le centre ville de Toulouse, vous pouvez utiliser :
  <strong>- le bus :</strong> terminus de la ligne 73 (de 6h à 21h) se situant à 100m de la maison et vous conduisant au terminus de la ligne de métro B « Borderouge ».
  <strong>- votre voiture :</strong> possibilité de la garer dans un des innombrables parking en centre ville ou dans un des parking relais d'une station de métro. L'accès parking est inclus dans le ticket de métro, il faut juste penser à le garder avec soi quand on quitte le parking. <strong>Attention,</strong> Tisseo n'accepte pas que l'on laisse sa voiture toute la nuit sur un de leurs parkings et facture la prestation."
)

Content.create(
  name: "before_booking_title",
  html: "Avant de réserver"
)

Content.create(
  name: "before_booking_description",
  html: "<p>Vous pouvez consulter les disponibilités et nous envoyer une demande de réservation directement
    <strong><a href='https://www.residence-lestang.com/rooms/la-maison'>ici pour la maison</a></strong> et
    <strong><a href='https://www.residence-lestang.com/rooms/les-chambres'>ici pour les chambres</a></strong>.
    Nous vous répondrons dans les meilleurs délais avec le contrat de location.</p>
    <br />
    <p>Pour toute question avant votre demande de réservation, vous pouvez nous contacter via le formulaire de contact.</p>
  "
)

  Content.create(
    name: "contact_form_title",
    html: "Formulaire de contact"
  )

  Content.create(
    name: "contact_form_description",
    html: "<p class='fst-italic m-0'>
    En renseignant vos informations, vous acceptez le fait d'envoyer un e-mail à notre adresse <span class='text-blue text-decoration-underline'>etrebil.ee30@gmail.com</span> avec les informations remplies.
    </p>
    "
  )

  puts "#{Content.count} contents created!"

  Room.first.update(description: "En séjournant dans notre maison, vous pourrez profiter d'un cadre de vie chaleureux et convivial, avec une décoration soignée qui reflète notre personnalité et notre style de vie. Notre maison est équipée de tout ce dont vous aurez besoin pour passer un séjour confortable, notamment une cuisine entièrement équipée, une salle de bains moderne et des chambres confortables.")
  Room.last.update(description: "Nous proposons deux chambres confortables, lumineuses et climatisées, équipées d'un lit Queen size et d'un dressing pour ranger vos effets personnels. Vous aurez également accès à une salle de bain privative ainsi qu'au reste des parties communes partagées avec nous.")

  Room.last.update(slug: "les-chambres")

  Room.first.update(description_title: "Un logement tranquille avec jardin et terrasse")
  Room.first.update(detailed_short_description:
    "<p>
      Bienvenue dans notre charmante maison située dans un <strong>quartier calme et verdoyant.</strong>
      <br>Cette maison est notre résidence principale, mais lorsque nous sommes en déplacement, nous aimons la partager avec des voyageurs en quête de confort et de tranquillité.
      <br>En séjournant dans notre maison, vous pourrez profiter d'un <strong>cadre de vie chaleureux et convivial,</strong> avec une décoration soignée qui reflète notre personnalité et notre style de vie.
    </p>
    <p class='text-blue fw-bold'>A noter</p>
    <ul>
      <li>Personnes non prévues dans la réservation interdites</li>
      <li>Fêtes interdites</li>
      <li>Animaux interdits</li>
    </ul>
    "
  )
  Room.first.update(detailed_long_description:
    "
    <p>
    Bienvenue dans notre charmante maison située dans un <strong>quartier calme et verdoyant.</strong>
    <br>Cette maison est notre résidence principale, mais lorsque nous sommes en déplacement, nous aimons la partager avec des voyageurs en quête de confort et de tranquillité.
    <br>En séjournant dans notre maison, vous pourrez profiter d'un <strong>cadre de vie chaleureux et convivial,</strong> avec une décoration soignée qui reflète notre personnalité et notre style de vie.
  </p>
  <br/>
  <p class='text-blue fw-bold'>Le logement</p>
  <br/>
  <ul>
    <li><strong>Maison entière</strong> située dans un quartier calme et verdoyant</li>
    <li><strong>Arrivée autonome</strong></li>
    <li><strong>Climatisation</strong> pour se sentir au frais même quand il fait chaud</li>
    <li><strong>8 couchages</strong> : 3 chambres avec lits Queen size et 1 canapé lit double convertible dans le séjour</li>
    <li><strong>Parking sécurisé</strong></li>
    <li><strong>Wifi internet haut débit / fibre</strong></li>
    <li><strong>Ordinateur et vidéoprojecteur</strong> équipé d'un <strong>chromecast</strong> pour se divertir</li>
    <li><strong>Imprimante</strong> pour scanner, copier et imprimer vos documents</li>
    <li><strong>Kit de repassage</strong> pour éviter les robes ou chemises froissés</li>
    <li><strong>Cuisiné équipée</strong> pour jouer les chefs étoilés et savourer la gastronomie Toulousaine</li>
    <li><strong>Machine à laver & étendoir</strong> (intérieur et extérieur) pour avoir des vêtements propres en toutes circonstances</li>
    <li><strong>Machine à café, thé</strong> sont présents afin de se sentir comme à la maison</li>
    <li><strong>Jardin et terrasse</strong> pour profiter des journées ensoleillées</li>
  </ul>
  <br/>
  <p class='text-blue fw-bold'>Accès des voyageurs</p>
  <br/>
  <p>Notre maison est équipée de tout ce dont vous aurez besoin pour passer un séjour confortable, notamment une cuisine entièrement équipée, une salle de bains moderne et des chambres confortables.
    <br>La maison dispose également d'un jardin paisible, parfait pour se détendre et profiter du soleil pendant les jours chauds d'été. Vous pourrez également explorer les environs et découvrir les nombreux restaurants, bars et attractions touristiques à proximité.
  </p>
  <br/>
  <p class='text-blue fw-bold'>Autres remarques</p>
  <br/>
  <ul>
    <li>Personnes non prévues dans la réservation interdites</li>
    <li>Fêtes interdites</li>
    <li>Animaux interdits</li>
  </ul>
    "
  )

  Room.first.update(
      the_plus: "<p class='with-comment fw-bold'>Parfait pour l'été</p>
    <p class='comment'>Jardin, terrasse, climatisation et barbecue</p>
    <br />
    <p class='with-comment fw-bold'>Espace de travail dédié</p>
    <p class='comment'>Un espace commun avec wifi, bien aménagé pour travailler</p>
    <br />
    <p class='with-comment fw-bold'>Annulation gratuite pendant 48 heures</p>
    <p class='comment m-0'>Hors frais bancaires et sauf si réservation dans les 48 heures avant la location</p>
  ")

Room.last.update(
    the_plus: "<p class='with-comment fw-bold'>Idéal pour le télétravail</p>
      <p class='comment'>Une connexion wifi rapide à 68 Mbit/s, plus un espace de travail dans un espace commun.</p>
      <br />
      <p class='with-comment fw-bold'>Parfait pour l'été</p>
      <p class='comment'>Jardin, terrasse et climatisation</p>
      <br />
      <p class='with-comment fw-bold'>Arrivée autonome</p>
      <p class='comment m-0'>Vous pouvez entrer dans les lieux avec une serrure à digicode.</p>
    ")

  Room.last.update(description_title: "Deux chambres privées dans notre logement")
  Room.last.update(detailed_short_description:
    "<p>Bienvenue chez nous !
    <br>Nous sommes un couple chaleureux et accueillant, et nous sommes ravis de vous accueillir chez nous.
    <br>Notre maison est située dans un quartier paisible, à proximité des transports en commun et des commodités.
    <br>Nous proposons deux chambres confortables et lumineuses, équipée chacune d'un lit Queensize.
    <br>Vous aurez également accès à une salle de bain moderne, ainsi qu'à notre cuisine et salon où vous pourrez préparer vos repas et partager des moments de convivialité avec nous.
  </p>
    "
  )

Room.last.update(detailed_long_description:
  "<p>Bienvenue chez nous !
    <br>Nous sommes un couple chaleureux et accueillant, et nous sommes ravis de vous accueillir chez nous.
    <br>Notre maison est située dans un quartier paisible, à proximité des transports en commun et des commodités.
    <br>Nous proposons deux chambres confortables et lumineuses, équipée chacune d'un lit Queensize.
    <br>Vous aurez également accès à une salle de bain moderne, ainsi qu'à notre cuisine et salon où vous pourrez préparer vos repas et partager des moments de convivialité avec nous.
  </p>
  <br/>
  <p class='text-blue fw-bold'>Le logement</p>
  <br/>
  <ul>
    <li><strong>2 chambres</strong> situées dans un quartier calme et verdoyant</li>
    <li><strong>4 couchages</strong> avec 2 lits Queen Size</li>
    <li><strong>1 salle de bain</strong> privative</li>
    <li><strong>Climatisation</strong> pour se sentir au frais même quand il fait chaud</li>
  </ul>
  <br/>
  <p class='text-blue fw-bold'>Partagés avec les hôtes</p>
  <br/>
  <ul>
    <li><strong>Arrivée autonome</strong></li>
    <li><strong>Place de stationnement</strong> juste devant la maison avec possibilité de se garer sur le <strong>parking sécurisé</strong> si besoin</li>
    <li><strong>Wifi internet haut débit / fibre</strong></li>
    <li><strong>Ordinateur et vidéoprojecteur</strong> équipé d'un <strong>chromecast</strong> pour se divertir</li>
    <li><strong>Imprimante</strong> pour scanner, copier et imprimer vos documents</li>
    <li><strong>Salle de yoga</strong> pour vous détendre (musique et diffuseur d'huile essentielle)</li>
    <li><strong>Kit de repassage</strong> pour éviter les robes ou chemises froissés</li>
    <li><strong>Cuisiné équipée</strong> pour jouer les chefs étoilés et savourer la gastronomie Toulousaine</li>
    <li><strong>Machine à laver & étendoir</strong> (intérieur et extérieur) pour avoir des vêtements propres en toutes circonstances</li>
    <li><strong>Machine à café, thé</strong> sont présents afin de se sentir comme à la maison</li>
    <li><strong>Jardin et terrasse</strong> pour profiter des journées ensoleillées</li>
  </ul>
  <br/>
  <p class='text-blue fw-bold'>Accès des voyageurs</p>
  <br/>
  <ul>
    <li>Chambres privatives à l'étage avec salle de bain attenante.</li>
    <li>Parties communes en RdC (salon, cuisine, terrasse, jardin).</li>
  </ul>
  <br/>
  <p class='text-blue fw-bold'>Autres remarques</p>
  <br/>
  <ul>
    <li>Situé à 100m de la ligne 73 se rendant à une station de métro pour ne pas s'encombrer d'une voiture en ville (fonctionne de 6h à 21h)</li>
    <li>Situé à 400m du lac de la Tuilerie</li>
    <li>Situé à 500m d'un maître Artisan Boulanger d'exception</li>
    <li>Situé à 15 min de la cité de l'Espace</li>
    <li>Situé à 20 min du Capitole</li>
  </ul>
  "
)

### End of next production


# puts "Cleaning database..."
# Content.destroy_all
# Review.destroy_all
# Message.destroy_all
# Chatroom.destroy_all
# Booking.destroy_all

# ### Comment 5 next lines after first time in production
# RoomPrice.destroy_all
# Season.destroy_all
# Slot.destroy_all
# # Room.destroy_all
# # User.destroy_all

# puts "Database cleaned!"

# ## Comment next lines after first time in production

# # puts "Creating 2 admin users..."

# # User.create(
# #   email: ENV['ADMIN_EMAIL_1'].to_s,
# #   password: ENV['ADMIN_PASSWORD_1'].to_s,
# #   first_name: "Emilie",
# #   last_name: "et Erlé",
# #   admin: true
# # )

# # User.create(
# #   email: ENV['ADMIN_EMAIL_2'].to_s,
# #   password: ENV['ADMIN_PASSWORD_2'].to_s,
# #   first_name: "Gwendal",
# #   last_name: "Le Bris",
# #   admin: true
# # )

# # puts "2 admin users created!"

# # puts "Creating 2 normal users..."

# # User.create(
# #   email: "coco@me.com",
# #   password: "password",
# #   first_name: "Corentin",
# #   last_name: "Le Bris",
# #   admin: false
# # )

# # User.create(
# #   email: "gireg@me.com",
# #   password: "password",
# #   first_name: "Gireg",
# #   last_name: "Le Bris",
# #   admin: false
# # )

# # puts "2 normal users created!"

# # puts "Creating 2 rooms..."

# # description_maison = "En séjournant dans notre maison, vous pourrez profiter d'un cadre de vie chaleureux et convivial, avec une décoration soignée qui reflète notre personnalité et notre style de vie. Notre maison est équipée de tout ce dont vous aurez besoin pour passer un séjour confortable, notamment une cuisine entièrement équipée, une salle de bains moderne et des chambres confortables."

# # maison = Room.create(
# #   name: "La Maison",
# #   description: description_maison,
# #   max_guests: 8,
# #   arrival_hour: "à partir de 14:00",
# #   departure_hour: "avant 12:00",
# #   bedrooms: 3,
# #   beds: 3,
# #   bathrooms: 2,
# #   min_nights: 1,
# #   max_nights: 15,
# #   available_days: 365,
# #   default_available_slots: false
# # )

# # description_chambre = "Nous proposons 2 chambres confortables, lumineuses et climatisées, équipées chacune d'un lit Queen size et d'un dressing pour ranger vos effets personnels. Vous aurez également accès au reste des parties communes partagées avec nous."

# # chambre = Room.create(
# #   name: "Les Chambres",
# #   description: description_chambre,
# #   max_guests: 2,
# #   arrival_hour: "entre 18:00 et 22:00",
# #   departure_hour: "avant 11:00",
# #   bedrooms: 1,
# #   beds: 1,
# #   bathrooms: 1,
# #   min_nights: 1,
# #   max_nights: -1,
# #   available_days: 92,
# #   default_available_slots: true
# # )

# # puts "2 rooms created!"

# puts "Creating 2 room prices..."

# RoomPrice.create(
#   room: Room.first,
#   night_price: 160,
#   medium_guests: 7,
#   night_price_medium_guests: 170,
#   high_guests: 8,
#   night_price_high_guests: 180,
#   week_reduction: -32,
#   medium_reduction: -32,
#   high_reduction: -64,
#   small_cleaning_fee: 30,
#   medium_cleaning_fee: 60,
#   high_cleaning_fee: 60
# )

# RoomPrice.create(
#   room: Room.last,
#   night_price: 40,
#   week_reduction: -6,
#   medium_reduction: -6,
#   high_reduction: -14
# )

# puts "2 room prices created!"

# puts "Creating 5 seasons..."

# Season.create(
#   room: Room.first,
#   start_date: DateTime.new(2024, 7, 25, 14, 0, 0),
#   end_date: DateTime.new(2024, 7, 30, 12, 0, 0),
#   min_nights: 3
# )

# Season.create(
#   room: Room.first,
#   start_date: DateTime.new(2024, 5, 13, 14, 0, 0),
#   end_date: DateTime.new(2024, 5, 21, 12, 0, 0),
#   min_nights: 3
# )

# Season.create(
#   room: Room.first,
#   start_date: DateTime.new(2024, 6, 9, 14, 0, 0),
#   end_date: DateTime.new(2024, 6, 11, 12, 0, 0),
#   min_nights: 2
# )

# Season.create(
#   room: Room.first,
#   start_date: DateTime.new(2024, 8, 12, 14, 0, 0),
#   end_date: DateTime.new(2024, 8, 15, 12, 0, 0),
#   min_nights: 2
# )

# Season.create(
#   room: Room.first,
#   start_date: DateTime.new(2024, 7, 8, 14, 0, 0),
#   end_date: DateTime.new(2024, 7, 23, 12, 0, 0),
#   min_nights: 6
# )

# puts "5 seasons created!"

# puts "Creating slots for Bedroom..."

# slots = [
#   { start_date: DateTime.new(2024, 5, 4, 18, 0, 0), end_date: DateTime.new(2024, 5, 8, 11, 0, 0) },
#   { start_date: DateTime.new(2024, 5, 12, 18, 0, 0), end_date: DateTime.new(2024, 5, 13, 11, 0, 0) },
#   { start_date: DateTime.new(2024, 5, 21, 18, 0, 0), end_date: DateTime.new(2024, 5, 22, 11, 0, 0) },
#   { start_date: DateTime.new(2024, 5, 26, 18, 0, 0), end_date: DateTime.new(2024, 5, 27, 11, 0, 0) },
#   { start_date: DateTime.new(2024, 6, 11, 18, 0, 0), end_date: DateTime.new(2024, 6, 12, 11, 0, 0) },
#   { start_date: DateTime.new(2024, 6, 16, 18, 0, 0), end_date: DateTime.new(2024, 6, 17, 11, 0, 0) },
#   { start_date: DateTime.new(2024, 6, 18, 18, 0, 0), end_date: DateTime.new(2024, 6, 19, 11, 0, 0) },
#   { start_date: DateTime.new(2024, 6, 30, 18, 0, 0), end_date: DateTime.new(2024, 7, 1, 11, 0, 0) },
#   { start_date: DateTime.new(2024, 7, 2, 18, 0, 0), end_date: DateTime.new(2024, 7, 8, 11, 0, 0) },
#   { start_date: DateTime.new(2024, 7, 23, 18, 0, 0), end_date: DateTime.new(2024, 7, 25, 11, 0, 0) },
#   { start_date: DateTime.new(2024, 7, 31, 18, 0, 0), end_date: DateTime.new(2024, 8, 1, 11, 0, 0) },
#   { start_date: DateTime.new(2024, 8, 4, 18, 0, 0), end_date: DateTime.new(2024, 8, 5, 11, 0, 0) },
#   { start_date: DateTime.new(2024, 8, 11, 18, 0, 0), end_date: DateTime.new(2024, 8, 12, 11, 0, 0) },
#   { start_date: DateTime.new(2024, 8, 15, 18, 0, 0), end_date: DateTime.new(2024, 8, 17, 11, 0, 0) },
#   { start_date: DateTime.new(2024, 8, 25, 18, 0, 0), end_date: DateTime.new(2024, 8, 28, 11, 0, 0) },

# ]

# slots.each do |slot|
#   Slot.create(
#     room: Room.last,
#     start_date: slot[:start_date],
#     end_date: slot[:end_date],
#     available: false
#   )
# end

# puts "#{Slot.where(room_id: Room.last.id).count} slots for bedroom created!"

# puts "Creating slots for House..."

# slots = [
#   { start_date: DateTime.new(2024, 5, 13, 14, 0, 0), end_date: DateTime.new(2024, 5, 21, 12, 0, 0) },
#   { start_date: DateTime.new(2024, 5, 27, 14, 0, 0), end_date: DateTime.new(2024, 5, 28, 12, 0, 0) },
#   { start_date: DateTime.new(2024, 6, 9, 14, 0, 0), end_date: DateTime.new(2024, 6, 11, 12, 0, 0) },
#   { start_date: DateTime.new(2024, 6, 17, 14, 0, 0), end_date: DateTime.new(2024, 6, 18, 12, 0, 0) },
#   { start_date: DateTime.new(2024, 7, 1, 14, 0, 0), end_date: DateTime.new(2024, 7, 2, 12, 0, 0) },
#   { start_date: DateTime.new(2024, 7, 8, 14, 0, 0), end_date: DateTime.new(2024, 7, 23, 12, 0, 0) },
#   { start_date: DateTime.new(2024, 7, 25, 14, 0, 0), end_date: DateTime.new(2024, 7, 31, 12, 0, 0) },
#   { start_date: DateTime.new(2024, 8, 5, 14, 0, 0), end_date: DateTime.new(2024, 8, 6, 12, 0, 0) },
#   { start_date: DateTime.new(2024, 8, 12, 14, 0, 0), end_date: DateTime.new(2024, 8, 15, 12, 0, 0) },
#   { start_date: DateTime.new(2024, 8, 19, 14, 0, 0), end_date: DateTime.new(2024, 8, 20, 12, 0, 0) }
# ]

# slots.each do |slot|
#   Slot.create(
#     room: Room.first,
#     start_date: slot[:start_date],
#     end_date: slot[:end_date],
#     available: true
#   )
# end

# puts "#{Slot.where(room_id: Room.first.id).count} slots for house created!"

# ### Finish commenting lines after first time in production

# # coco = User.find_by(first_name: "Corentin")
# # gireg = User.find_by(first_name: "Gireg")
# gwen = User.find_by(first_name: "Gwendal")

# puts "Creating 2 bookings..."

# booking1 = Booking.create(
#   user: gwen,
#   room: Room.first,
#   arrival: DateTime.new(2024, 5, 27, 14, 0, 0),
#   departure: DateTime.new(2024, 5, 28, 12, 0, 0),
#   guests_number: 4,
#   status: "acceptée"
# )

# booking2 = Booking.create(
#   user: gwen,
#   room: Room.first,
#   arrival: DateTime.new(2024, 7, 1, 14, 0, 0),
#   departure: DateTime.new(2024, 7, 2, 12, 0, 0),
#   guests_number: 7,
#   status: "acceptée"
# )

# booking3 = Booking.create(
#   user: gwen,
#   room: Room.first,
#   arrival: DateTime.new(2024, 6, 1, 14, 0, 0),
#   departure: DateTime.new(2024, 6, 30, 12, 0, 0),
#   guests_number: 8,
#   status: "en attente"
# )

# booking4 = Booking.create(
#   user: gwen,
#   room: Room.last,
#   arrival: DateTime.new(2024, 5, 26, 18, 0, 0),
#   departure: DateTime.new(2024, 5, 29, 11, 0, 0),
#   guests_number: 1,
#   status: "refusée"
# )

# booking4 = Booking.create(
#   user: gwen,
#   room: Room.last,
#   arrival: DateTime.new(2024, 5, 5, 18, 0, 0),
#   departure: DateTime.new(2024, 5, 9, 11, 0, 0),
#   guests_number: 1,
#   status: "en attente"
# )

# booking5 = Booking.create(
#   user: gwen,
#   room: Room.last,
#   arrival: DateTime.new(2024, 5, 12, 18, 0, 0),
#   departure: DateTime.new(2024, 5, 22, 11, 0, 0),
#   guests_number: 2,
#   status: "en attente"
# )

# booking6 = Booking.create(
#   user: gwen,
#   room: Room.last,
#   arrival: DateTime.new(2024, 5, 26, 18, 0, 0),
#   departure: DateTime.new(2024, 5, 29, 11, 0, 0),
#   guests_number: 1,
#   status: "en attente"
# )

# booking8 = Booking.create(
#   user: gwen,
#   room: Room.last,
#   arrival: DateTime.new(2024, 2, 20, 18, 0, 0),
#   departure: DateTime.new(2024, 2, 22, 11, 0, 0),
#   guests_number: 1,
#   status: "en attente"
# )

# booking9 = Booking.create(
#   user: gwen,
#   room: Room.last,
#   arrival: DateTime.new(2024, 6, 1, 18, 0, 0),
#   departure: DateTime.new(2024, 6, 30, 11, 0, 0),
#   guests_number: 1,
#   status: "en attente"
# )

# booking10 = Booking.create(
#   user: gwen,
#   room: Room.first,
#   arrival: DateTime.new(2024, 7, 1, 14, 0, 0),
#   departure: DateTime.new(2024, 7, 2, 12, 0, 0),
#   guests_number: 1,
#   status: "en attente"
# )

# puts "#{Booking.count} bookings created!"
# puts "#{Chatroom.count} chatrooms created!"

# # puts "Creating reviews..."

# # author1 = "Claude - décembre 2022"
# # content1 = "Très bon séjour dans cette maison. On a trouvé la maison plus belle en vrai qu'en photos.
# # Nous y avons passé un très bon Noël en famille.
# # Maison très propre, et principe de la clé électronique très pratique.
# # Merci aussi pour la petite attention à notre arrivée.
# # À recommander pour les familles nombreuses !"
# # Review.create(author: author1, content: content1, room_id: Room.first.id)

# # author2 = "Audrey - octobre 2022"
# # content2 = "Maison magnifique, décorée avec goût, spacieuse et à deux pas de Toulouse. Les photos ne lui rendent pas justice : elle est encore plus jolie en vrai !
# # La literie est de grande qualité, du matelas jusqu'aux coussins. Tout est super bien expliqué : le fonctionnement de la porte d'entrée, des différents éléments de la cuisine...
# # Merci pour cette belle parenthèse dans notre weekend toulousain."
# # Review.create(author: author2, content: content2, room_id: Room.first.id)

# # author3 = "Elea - mai 2022"
# # content3 = "Le logement est fidèle à l'annonce, la communication est fluide et l'arrivée très bien organisée.
# # Si vous souhaitez passer un séjour sur Toulouse et loger dans un quartier calme et appairant je vous recommande vivement celui-ci.
# # De plus Émilie est très réactive en cas de besoin, pour toutes questions.
# # Ce fût un très bon séjour pour nous qui étions 7 avec tout le nécessaire à disposition."
# # Review.create(author: author3, content: content3, room_id: Room.first.id)

# # puts "Reviews created!"

# puts "Finished!"
