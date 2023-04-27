class AddNightsToRooms < ActiveRecord::Migration[7.0]
  def change
    add_column :rooms, :min_nights, :integer
    add_column :rooms, :max_nights, :integer
  end
end
