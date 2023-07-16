class AddBankFeesAndCautionToRoomsAndBookings < ActiveRecord::Migration[7.0]
  def change
    add_column :rooms, :bank_fees, :float, default: 0
    add_column :rooms, :caution, :integer, default: 0
    add_column :bookings, :bank_fees, :float, default: 0
    add_column :bookings, :total_price, :float, default: 0
    add_column :bookings, :caution, :integer, default: 0
  end
end
