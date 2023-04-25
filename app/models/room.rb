class Room < ApplicationRecord
  has_many :bookings
  has_many :users, through: :bookings
  has_one :room_price

  validates :name, :description, :max_guests, presence: true

  def dates_disabled
    bookings.where(status: "acceptée").map do |booking|
      {
        from: booking.start_date,
        to: booking.end_date - (booking.end_date.hour + 4) * 3600
      }
    end
  end

  def max_guests
    case name
    when "La Maison"
      8
    when "La Chambre"
      2
    end
  end
end
