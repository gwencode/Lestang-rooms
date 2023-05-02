class Room < ApplicationRecord
  has_many :bookings
  has_many :users, through: :bookings
  has_many :seasons
  has_many :slots
  has_one :room_price

  validates :name, :description, :max_guests, presence: true

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

# # SLOTS
# arrivals_enabled = [
#   {:from=>Fri, 12 May 2023 20:00:00.000000000 UTC +00:00, :to=>Sat, 20 May 2023 20:00:00.000000000 UTC +00:00},
#   {:from=>Fri, 26 May 2023 20:00:00.000000000 UTC +00:00, :to=>Sat, 27 May 2023 20:00:00.000000000 UTC +00:00},
#   {:from=>Thu, 08 Jun 2023 20:00:00.000000000 UTC +00:00, :to=>Sat, 10 Jun 2023 20:00:00.000000000 UTC +00:00},
#   {:from=>Fri, 16 Jun 2023 20:00:00.000000000 UTC +00:00, :to=>Sat, 17 Jun 2023 20:00:00.000000000 UTC +00:00},
#   {:from=>Fri, 30 Jun 2023 20:00:00.000000000 UTC +00:00, :to=>Sat, 01 Jul 2023 20:00:00.000000000 UTC +00:00},
#   {:from=>Fri, 07 Jul 2023 20:00:00.000000000 UTC +00:00, :to=>Sat, 22 Jul 2023 20:00:00.000000000 UTC +00:00},
#   {:from=>Mon, 24 Jul 2023 20:00:00.000000000 UTC +00:00, :to=>Sun, 30 Jul 2023 20:00:00.000000000 UTC +00:00},
#   {:from=>Fri, 04 Aug 2023 20:00:00.000000000 UTC +00:00, :to=>Sat, 05 Aug 2023 20:00:00.000000000 UTC +00:00},
#   {:from=>Fri, 11 Aug 2023 20:00:00.000000000 UTC +00:00, :to=>Mon, 14 Aug 2023 20:00:00.000000000 UTC +00:00},
#   {:from=>Fri, 18 Aug 2023 20:00:00.000000000 UTC +00:00, :to=>Sat, 19 Aug 2023 20:00:00.000000000 UTC +00:00}
# ]

# # BOOKINGS
# arrivals_disabled = [
#   {:from=>Sun, 14 May 2023 20:00:00.000000000 UTC +00:00, :to=>Wed, 17 May 2023 20:00:00.000000000 UTC +00:00}
#   {:from=>Fri, 26 May 2023 20:00:00.000000000 UTC +00:00, :to=>Sat, 27 May 2023 20:00:00.000000000 UTC +00:00},
#   {:from=>Fri, 30 Jun 2023 20:00:00.000000000 UTC +00:00, :to=>Sat, 01 Jul 2023 20:00:00.000000000 UTC +00:00},
#   {:from=>Fri, 11 Aug 2023 20:00:00.000000000 UTC +00:00, :to=>Sat, 12 Aug 2023 20:00:00.000000000 UTC +00:00}
# ]

# new_arrivals_enabled = [
#   {:from=>Fri, 12 May 2023 20:00:00.000000000 UTC +00:00, :to=>Sun, 14 May 2023 20:00:00.000000000 UTC +00:00},
#   {:from=>Wed, 17 May 2023 20:00:00.000000000 UTC +00:00, :to=>Sat, 20 May 2023 20:00:00.000000000 UTC +00:00},
#   {:from=>Thu, 08 Jun 2023 20:00:00.000000000 UTC +00:00, :to=>Sat, 10 Jun 2023 20:00:00.000000000 UTC +00:00},
#   {:from=>Fri, 16 Jun 2023 20:00:00.000000000 UTC +00:00, :to=>Sat, 17 Jun 2023 20:00:00.000000000 UTC +00:00},
#   {:from=>Fri, 07 Jul 2023 20:00:00.000000000 UTC +00:00, :to=>Sat, 22 Jul 2023 20:00:00.000000000 UTC +00:00},
#   {:from=>Mon, 24 Jul 2023 20:00:00.000000000 UTC +00:00, :to=>Sun, 30 Jul 2023 20:00:00.000000000 UTC +00:00},
#   {:from=>Fri, 04 Aug 2023 20:00:00.000000000 UTC +00:00, :to=>Sat, 05 Aug 2023 20:00:00.000000000 UTC +00:00},
#   {:from=>Sat, 12 Aug 2023 20:00:00.000000000 UTC +00:00, :to=>Mon, 14 Aug 2023 20:00:00.000000000 UTC +00:00},
#   {:from=>Fri, 18 Aug 2023 20:00:00.000000000 UTC +00:00, :to=>Sat, 19 Aug 2023 20:00:00.000000000 UTC +00:00}
# ]
