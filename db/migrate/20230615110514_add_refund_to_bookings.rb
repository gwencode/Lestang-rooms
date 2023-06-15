class AddRefundToBookings < ActiveRecord::Migration[7.0]
  def change
    add_column :bookings, :refund, :boolean, default: false
    add_column :bookings, :refund_amount, :integer
  end
end
