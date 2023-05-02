class Slot < ApplicationRecord
  belongs_to :room

  validates :start_date, :end_date, presence: true
  validates :room, presence: true
  validate :end_date_after_start_date
  validate :slot_available

  after_create :create_second_slot, if: -> { room == Room.first && available == true }
  after_update :update_second_slot, if: -> { room == Room.first && available == true }
  after_destroy :destroy_second_slot, if: -> { room == Room.first && available == true }

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

  private

  def create_second_slot
    Slot.create(start_date: start_date, end_date: end_date, room: Room.last, available: false)
  end

  def update_second_slot
    slot_maison = self
    slot_chambre = self.class.find(id + 1)
    slot_chambre.update(start_date: slot_maison.start_date, end_date: slot_maison.end_date) if slot_chambre
  end

  def destroy_second_slot
    slot_chambre = self.class.find(id + 1)
    slot_chambre.destroy if slot_chambre
  end
end
