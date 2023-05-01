class Season < ApplicationRecord
  belongs_to :room

  validates :start_date, :end_date, :min_nights, presence: true
  validate :end_date_after_start_date
  validate :min_nights_is_positive

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?

    if end_date <= start_date
      errors.add(:end_date, "La date de fin doit être après la date de début")
    end
  end

  def min_nights_is_positive
    return if min_nights.blank?

    if min_nights < 1
      errors.add(:min_nights, "Le nombre de nuits minimum doit être supérieur à 0")
    end
  end
end
