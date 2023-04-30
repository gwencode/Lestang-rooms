class BookingsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[create]

  def create
    @booking = Booking.new(booking_params)

    authorize @booking

    @booking.room = Room.find(params[:room_id])
    @booking.arrival = @booking.arrival.change(hour: set_hour[:arrival])
    @booking.departure = @booking.departure.change(hour: set_hour[:departure])
    # @booking.booking_price = @booking.calculate_booking_price
    @booking.status = "en attente"
    @booking.user = current_user

    if @booking.save
      redirect_to root_path, notice: "Votre demande de réservation a bien été envoyée"
      # flash[:notice] = "Votre demande de réservation a bien été envoyée"
    else
      redirect_to room_path(@booking.room), alert: @booking.errors.messages.values.join(", ")
      return
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:arrival, :departure, :guests_number)
  end

  def set_hour
    case @booking.room.name
    when "La Maison"
      { arrival: 14, departure: 12 }
    when "La Chambre"
      { arrival: 18, departure: 11 }
    end
  end
end
