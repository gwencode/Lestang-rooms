class CreateSlots < ActiveRecord::Migration[7.0]
  def change
    create_table :slots do |t|
      t.references :room, null: false, foreign_key: true
      t.datetime :start_date
      t.datetime :end_date
      t.boolean :available

      t.timestamps
    end
  end
end
