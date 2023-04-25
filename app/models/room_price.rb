class RoomPrice < ApplicationRecord
  belongs_to :room
  before_save :set_night_price_week_reduction

  private

  def set_night_price_week_reduction
    self.night_price_week_reduction = night_price + week_reduction
  end
end
