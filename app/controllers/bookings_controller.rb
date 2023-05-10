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
      redirect_to booking_path(@booking), notice: "Votre demande de réservation a bien été envoyée"
      # flash[:notice] = "Votre demande de réservation a bien été envoyée"
    else
      redirect_to room_path(@booking.room), alert: @booking.errors.messages.values.join(", ")
      return
    end
  end

  def index
    @bookings = policy_scope(Booking).order(created_at: :desc)
  end

  def show
    @booking = Booking.find(params[:id])
    authorize @booking, :show?

    @room = @booking.room

    @reduction_sentence = reduction_sentence(@booking) if @booking.reduction.negative?
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

  def reduction_sentence(booking)
    case booking.duration
    when "high"
      "Réduction location longue durée"
    when "medium"
      "Réduction location moyenne durée"
    when "week"
      "Réduction location à la semaine"
    else
      ""
    end
  end
end
