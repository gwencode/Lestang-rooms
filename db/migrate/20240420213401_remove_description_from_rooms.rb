class RemoveDescriptionFromRooms < ActiveRecord::Migration[7.0]
  def change
    remove_column :rooms, :description, :string
  end
end
