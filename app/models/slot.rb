class Slot < ApplicationRecord

  validates :start_date, :end_date, :available, presence: true
  validate :end_date_after_start_date

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?

    if end_date <= start_date
      errors.add(:end_date, "La date de fin doit être après la date de début")
    end
  end
end
