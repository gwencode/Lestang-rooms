class CreateRoomPrices < ActiveRecord::Migration[7.0]
  def change
    create_table :room_prices do |t|
      t.references :room, null: false, foreign_key: true
      t.integer :night_price
      t.integer :medium_guests, default: 0
      t.integer :night_price_medium_guests, default: 0
      t.integer :high_guests, default: 0
      t.integer :night_price_high_guests, default: 0
      t.integer :week_duration, default: 7
      t.integer :week_reduction
      t.integer :medium_duration, default: 15
      t.integer :medium_reduction
      t.integer :high_duration, default: 28
      t.integer :high_reduction
      t.integer :small_cleaning_duration, default: 2
      t.integer :small_cleaning_fee, default: 0
      t.integer :medium_cleaning_duration, default: 3
      t.integer :medium_cleaning_fee, default: 0
      t.integer :high_cleaning_duration, default: 7
      t.integer :high_cleaning_fee, default: 0

      t.timestamps
    end
  end
end
