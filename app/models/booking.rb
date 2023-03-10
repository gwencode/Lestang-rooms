class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :start_date, :end_date, :guests_number, :booking_price, :status, presence: true
  # validate :end_date_after_start_date
  # validate :start_date_after_today
  # validate :room_available

end
