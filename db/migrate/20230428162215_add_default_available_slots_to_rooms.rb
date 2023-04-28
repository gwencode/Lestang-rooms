class AddDefaultAvailableSlotsToRooms < ActiveRecord::Migration[7.0]
  def change
    add_column :rooms, :default_available_slots, :boolean, default: false
  end
end
