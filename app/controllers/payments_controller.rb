class PaymentsController < ApplicationController
  def new
    @booking = Booking.find(params[:booking_id])
    authorize @booking
    if @booking.paid || @booking.user != current_user || @booking.status != "acceptée"
      redirect_to booking_path(@booking), alert: "Vous ne pouvez pas payer cette réservation"
      return
    end
    @reduction_sentence = @booking.reduction_sentence if @booking.reduction.negative?
  end
end
