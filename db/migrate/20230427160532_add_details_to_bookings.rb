class AddDetailsToBookings < ActiveRecord::Migration[7.0]
  def change
    add_column :bookings, :night_price, :integer
    add_column :bookings, :nights, :integer
    add_column :bookings, :duration, :string, default: nil
    add_column :bookings, :reduction, :integer, default: 0
    add_column :bookings, :cleaning_fee, :integer, default: 0
  end
end
