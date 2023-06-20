class AddAirbnbBookingToSlot < ActiveRecord::Migration[7.0]
  def change
    add_column :slots, :airbnb_booking, :boolean, default: false
  end
end
