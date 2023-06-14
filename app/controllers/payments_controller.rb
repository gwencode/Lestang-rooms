class PaymentsController < ApplicationController
  def new
    @booking = Booking.find(params[:booking_id])
    authorize @booking
    if @booking.paid || @booking.user != current_user || @booking.status != "acceptée"
      redirect_to booking_path(@booking), alert: "Vous ne pouvez pas payer cette réservation"
      return
    end
  end
end
