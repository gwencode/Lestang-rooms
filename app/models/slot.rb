class Slot < ApplicationRecord
  belongs_to :room

  validates :start_date, :end_date, presence: true
  validate :end_date_after_start_date
  validate :slot_available

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?

    if end_date <= start_date
      errors.add(:end_date, "La date de fin doit être après la date de début")
    end
  end

  def slot_available
    return if end_date.blank? || start_date.blank?

    room.slots.excluding(self).each do |slot|
      if slot.start_date < end_date && slot.end_date > start_date
        errors.add(:créneau, "non disponible à ces dates")
      end
    end
  end
end
