class Room < ApplicationRecord
  has_many :bookings
  has_many :users, through: :bookings
  has_many :seasons
  has_one :room_price

  validates :name, :description, :max_guests, presence: true

  def arrivals_disabled
    if self.name == "La Chambre"
      Booking.all.where(status: "acceptée").map do |booking|
        {
          from: booking.arrival - ((booking.arrival.hour + 4) * 3600),
          to: booking.departure - ((booking.departure.hour + 4) * 3600)
        }
      end
    else
      bookings.where(status: "acceptée").map do |booking|
        {
          from: booking.arrival - ((booking.arrival.hour + 4) * 3600),
          to: booking.departure - ((booking.departure.hour + 4) * 3600)
        }
      end
    end
  end

  def departures_disabled
    bookings.where(status: "acceptée").map do |booking|
      {
        from: booking.arrival + ((20 - booking.arrival.hour) * 3600),
        to: booking.departure + ((20 - booking.departure.hour) * 3600)
      }
    end
  end
end
