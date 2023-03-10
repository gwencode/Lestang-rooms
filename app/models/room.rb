class Room < ApplicationRecord
  has_many :bookings
  has_many :users, through: :bookings

  validates :name, :description, :max_guests, :price_per_day, presence: true
end
