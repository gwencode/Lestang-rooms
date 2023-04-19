class Admin::BookingsController < ApplicationController

  def index
    # @bookings = policy_scope(Booking)
    @bookings = Booking.all
  end

  def show
    @booking = Booking.find(params[:id])
    # authorize @booking
  end

  def update
    @booking = Booking.find(params[:id])
    # authorize @booking
    # @booking.update(booking_params)
    # redirect_to admin_bookings_path
  end
end
