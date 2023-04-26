class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :start_date, :end_date, :guests_number, :status, presence: true
  validate :end_date_after_start_date
  validate :start_date_after_today
  validate :room_available

  before_save :set_booking_price

  def nights
    ((end_date - start_date) / 60 / 60 / 24).round
  end

  def guests_night_price
    case guests_number
    when 7
      room.room_price.night_price_seven_guests
    when 8
      room.room_price.night_price_eight_guests
    else
      room.room_price.night_price
    end
  end

  def basic_price
    nights * guests_night_price
  end

  def start_date_after_today
    return if start_date.blank?

    if start_date < DateTime.now
      errors.add(:start_date, "La date d'arrivée doit être après aujourd'hui")
    end
  end

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?

    if end_date <= start_date
      errors.add(:end_date, "La date de départ doit être après la date d'arrivée")
    end
  end

  def room_available
    return if start_date.blank? || end_date.blank?

    room.bookings.excluding(self).where(status: "acceptée").each do |booking|
      if booking.start_date < end_date && booking.end_date > start_date
        errors.add(:room, "Logement pas disponible à ces dates")
      end
    end
  end

  private

  def set_booking_price
    price = basic_price
    price += (room.room_price.week_reduction * nights)  if nights >= 7
    price += room.room_price.cleaning_fee
    self.booking_price = price
  end
end
