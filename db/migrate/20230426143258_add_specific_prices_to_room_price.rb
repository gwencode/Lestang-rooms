class AddSpecificPricesToRoomPrice < ActiveRecord::Migration[7.0]
  def change
    add_column :room_prices, :night_price_seven_guests, :integer, default: 0
    add_column :room_prices, :night_price_eight_guests, :integer, default: 0
  end
end
