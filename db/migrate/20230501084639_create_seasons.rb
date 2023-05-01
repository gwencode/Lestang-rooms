class CreateSeasons < ActiveRecord::Migration[7.0]
  def change
    create_table :seasons do |t|
      t.references :room, null: false, foreign_key: true
      t.datetime :start_date
      t.datetime :end_date
      t.integer :min_nights

      t.timestamps
    end
  end
end
