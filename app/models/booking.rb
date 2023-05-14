class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :room
  has_one :chatroom, dependent: :destroy

  validates :arrival, :departure, :guests_number, :status, presence: true
  validate :departure_after_arrival
  # validate :arrival_after_today
  validate :room_available
  validate :house_slot_available, if: -> { room == Room.first }
  validate :bedroom_slot_available, if: -> { room == Room.last }

  before_save :set_night_price, :set_nights, :set_duration, :set_reduction, :set_cleaning_fee, :set_booking_price

  def basic_price
    nights * night_price
  end

  def calculate_booking_price
    set_booking_price
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
        errors.add(:room, "Le logement n'est pas disponible à ces dates")
      end
    end
  end

  def house_slot_available
    return if arrival.blank? || departure.blank?

    room.slots.where(available: true).each do |slot|
      return true if slot.start_date <= arrival && arrival < slot.end_date && slot.start_date < departure && departure <= slot.end_date
    end
    errors.add(:room, "Le logement n'est pas disponible à ces dates")
  end

  def bedroom_slot_available
    return if arrival.blank? || departure.blank?

    room.slots.where(available: false).order("start_date ASC").each do |slot|
      if arrival < slot.start_date &&  departure > slot.end_date
        errors.add(:room, "Le logement n'est pas disponible à ces dates")
        return false
      end
    end
  end

  private

  def set_night_price
    case guests_number
    when room.room_price.medium_guests
      self.night_price = room.room_price.night_price_medium_guests
    when room.room_price.high_guests
      self.night_price = room.room_price.night_price_high_guests
    else
      self.night_price = room.room_price.night_price
    end
  end

  def set_nights
    self.nights = ((departure - arrival) / 60 / 60 / 24).round
  end

  def set_duration
    if nights >= room.room_price.high_duration
      self.duration = "high"
    elsif nights >= room.room_price.medium_duration
      self.duration = "medium"
    elsif nights >= room.room_price.week_duration
      self.duration = "week"
    else
      self.duration = nil
    end
  end

  def set_reduction
    case duration
    when "high"
      self.reduction = nights * room.room_price.high_reduction
    when "medium"
      self.reduction = nights * room.room_price.medium_reduction
    when "week"
      self.reduction = nights * room.room_price.week_reduction
    else
      self.reduction = 0
    end
  end

  def set_cleaning_fee
    if nights >= room.room_price.high_cleaning_duration
      self.cleaning_fee = room.room_price.high_cleaning_fee
    elsif nights >= room.room_price.medium_cleaning_duration
      self.cleaning_fee = room.room_price.medium_cleaning_fee
    else
      self.cleaning_fee = room.room_price.small_cleaning_fee
    end
  end

  def set_booking_price
    self.booking_price = basic_price + reduction + cleaning_fee
  end
end
