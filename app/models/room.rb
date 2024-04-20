class Room < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  has_rich_text :description
  has_rich_text :description_title
  has_rich_text :detailed_short_description
  has_rich_text :detailed_long_description

  has_many :bookings
  has_many :users, through: :bookings
  has_many :seasons
  has_many :slots
  has_one :room_price

  validates :name, :description, :max_guests, presence: true
  validates :bedrooms, :beds, :bathrooms, presence: true
  validates :arrival_hour, :departure_hour, presence: true
  validates :min_nights, :max_nights, :available_days, presence: true

  def slots_enabled
    array = slots.where(available: true).map do |slot|
      {
        from: slot.start_date - ((slot.start_date.hour + 4) * 3600),
        to: slot.end_date - ((slot.end_date.hour + 4) * 3600)
      }
    end
    array.sort_by { |slot| slot[:from] }
  end

  def slots_disabled
    array = slots.where(available: false).map do |slot|
      {
        from: slot.start_date - ((slot.start_date.hour + 4) * 3600),
        to: slot.end_date - ((slot.end_date.hour + 4) * 3600)
      }
    end
    array.sort_by { |slot| slot[:from] }
  end

  def arrivals_disabled
    array = Booking.all.where(status: "acceptée").map do |booking|
      {
        from: booking.arrival - ((booking.arrival.hour + 4) * 3600),
        to: booking.departure - ((booking.departure.hour + 4) * 3600)
      }
    end
    array += slots_disabled if slots_disabled
    array.sort_by { |slot| slot[:from] }
  end

  def departures_disabled
    array = arrivals_disabled.map do |slot|
      {from: slot[:from] += 24 * 3600, to: slot[:to] += 24 * 3600}
    end
    array.sort_by { |slot| slot[:from] }
  end

  def arrivals_enabled
    enables = slots_enabled
    disables = arrivals_disabled
    enables.each do |slot|
      if disables.include?(slot)
        disables.delete(slot)
        enables.delete(slot)
      end
    end

    enables.each do |slot|
      change = false
      disables.each do |booking|
        next if change == true

        if booking[:from] >= slot[:from] && booking[:to] <= slot[:to]
          enables << { from: slot[:from], to: booking[:from] }
          enables << { from: booking[:to], to: slot[:to] }
          disables.delete(booking)
          enables.delete(slot)
          change = true
        end
      end
    end
    return enables.sort_by { |slot| slot[:from] }
  end

  def departures_enabled
    array = arrivals_enabled.map do |slot|
      {from: slot[:from] += 24 * 3600, to: slot[:to] += 24 * 3600}
    end
    array.sort_by { |slot| slot[:from] }
  end
end
