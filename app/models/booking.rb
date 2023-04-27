class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :arrival, :departure, :guests_number, :status, presence: true
  validate :departure_after_arrival
  # validate :arrival_after_today
  validate :room_available

  before_save :set_booking_price

  def nights
    ((departure - arrival) / 60 / 60 / 24).round
  end

  def guests_night_price
    case guests_number
    when room.room_price.medium_guests
      room.room_price.night_price_medium_guests
    when room.room_price.high_guests
      room.room_price.night_price_high_guests
    else
      room.room_price.night_price
    end
  end

  def basic_price
    nights * guests_night_price
  end

  def arrival_after_today
    return if arrival.blank?

    if arrival < DateTime.now
      errors.add(:arrival, "La date d'arrivée doit être après aujourd'hui")
    end
  end

  def departure_after_arrival
    return if departure.blank? || arrival.blank?

    if departure <= arrival
      errors.add(:departure, "La date de départ doit être après la date d'arrivée")
    end
  end

  def room_available
    return if arrival.blank? || departure.blank?

    room.bookings.excluding(self).where(status: "acceptée").each do |booking|
      if booking.arrival < departure && booking.departure > arrival
        errors.add(:room, "Logement pas disponible à ces dates")
      end
    end
  end

  private

  def set_booking_price
    price = basic_price
    price += (room.room_price.week_reduction * nights) if nights >= 7
    price += room.room_price.cleaning_fee
    self.booking_price = price
  end
end
