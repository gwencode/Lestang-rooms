class BookingsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[create]

  def create
    @booking = Booking.new(booking_params)
    @booking.room = Room.find(params[:room_id])
    @booking.arrival = @booking.arrival.change(hour: set_hour[:arrival])
    @booking.departure = @booking.departure.change(hour: set_hour[:departure])
    @booking.booking_price = @booking.calculate_booking_price
    @booking.status = "en attente"
    @booking.user = current_user

    raise

    if @booking.save!
      redirect_to root_path
    else
      render 'rooms/show', status: :unprocessable_entity
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:arrival, :departure, :guests_number)
  end

  def set_hour
    if @booking.room.name == "La Maison"
      hour = { arrival: 14, departure: 12 }
    elsif @booking.room.name == "La Chambre"
      hour = { arrival: 18, departure: 11 }
    end
  end
end
