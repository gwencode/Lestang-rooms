class CreateRoomPrices < ActiveRecord::Migration[7.0]
  def change
    create_table :room_prices do |t|
      t.references :room, null: false, foreign_key: true
      t.integer :night_price
      t.integer :week_reduction
      t.integer :night_price_week_reduction
      t.integer :cleaning_fee

      t.timestamps
    end
  end
end
