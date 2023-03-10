class CreateRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :rooms do |t|
      t.string :name
      t.string :description
      t.integer :max_guests
      t.integer :price_per_day
      t.string :arrival_hour
      t.string :departure_hour

      t.timestamps
    end
  end
end
