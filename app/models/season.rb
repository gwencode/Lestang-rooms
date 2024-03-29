class Season < ApplicationRecord
  belongs_to :room

  validates :start_date, :end_date, :min_nights, presence: true
  validate :end_date_after_start_date
  validate :min_nights_is_positive
  validate :season_available

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?

    if end_date <= start_date
      errors.add(:end_date, "doit être après la date de début")
    end
  end

  def min_nights_is_positive
    return if min_nights.blank?

    if min_nights < 1
      errors.add(:min_nights, "doit être supérieur à 0")
    end
  end

  def season_available
    return if end_date.blank? || start_date.blank?

    room.seasons.excluding(self).each do |season|
      if season.start_date < end_date && season.end_date > start_date
        errors.add(:condition, "non disponible à ces dates")
      end
    end
  end
end
