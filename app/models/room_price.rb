class RoomPrice < ApplicationRecord
  belongs_to :room
  validates :night_price, presence: true
end
