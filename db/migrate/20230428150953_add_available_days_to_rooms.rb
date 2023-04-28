class AddAvailableDaysToRooms < ActiveRecord::Migration[7.0]
  def change
    add_column :rooms, :available_days, :integer, default: 0
  end
end
