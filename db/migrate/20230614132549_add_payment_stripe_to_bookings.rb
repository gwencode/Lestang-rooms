class AddPaymentStripeToBookings < ActiveRecord::Migration[7.0]
  def change
    add_column :bookings, :paid, :boolean, default: false
    add_column :bookings, :checkout_session_id, :string
  end
end
