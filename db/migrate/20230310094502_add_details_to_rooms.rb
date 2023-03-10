class AddDetailsToRooms < ActiveRecord::Migration[7.0]
  def change
    add_column :rooms, :bedrooms, :integer
    add_column :rooms, :beds, :integer
    add_column :rooms, :bathooms, :integer
  end
end
