class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :start_date, :end_date, :guests_number, :booking_price, :status, presence: true
  validate :end_date_after_start_date
  validate :start_date_after_today
  validate :room_available

  def nights
    ((end_date - start_date) / 60 / 60 / 24).round
  end

  def night_price
    case guests_number
    when 7
      room.price_per_day + 10
    when 8
      room.price_per_day + 20
    else
      room.price_per_day
    end
  end

  def basic_price
    nights * night_price
  end

  def night_price_week_reduction
    case room.name
    when "La Maison"
      night_price - 32
    when "La Chambre"
      night_price - 6
    end
  end

  def week_reduction
    if nights >= 7
      case room.name
      when "La Maison"
        - nights * 32
      when "La Chambre"
        - nights * 6
      end
    else
      0
    end
  end

  def cleaning_fee
    room.name == "La Maison" ? 60 : 0
  end

  def calculate_booking_price
    price = basic_price
    price += week_reduction
    price += cleaning_fee
    return price
  end

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?

    if end_date < start_date
      errors.add(:end_date, "doit être après la date d'arrivée")
    end
  end

  def start_date_after_today
    return if start_date.blank?

    if start_date < DateTime.now
      errors.add(:start_date, "doit être après aujourd'hui")
    end
  end

  def room_available
    return if start_date.blank? || end_date.blank?

    room.bookings.each do |booking|
      if booking.start_date < end_date && booking.end_date > start_date
        errors.add(:room, "pas disponible à ces dates")
      end
    end
  end
end
