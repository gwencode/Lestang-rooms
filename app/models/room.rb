class Room < ApplicationRecord
  has_many :bookings
  has_many :users, through: :bookings
  has_many :seasons
  has_one :room_price

  validates :name, :description, :max_guests, presence: true

  def dates_disabled
    bookings.where(status: "acceptée").map do |booking|
      {
        from: booking.arrival,
        to: booking.departure - (booking.departure.hour + 4) * 3600
      }
    end
  end
end
