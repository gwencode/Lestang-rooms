class Admin::BookingsController < ApplicationController
  before_action :set_booking, only: %i[show edit update accept decline]

  def index
    unless current_user.admin
      flash[:alert] = "Accès non autorisé."
      redirect_to(root_path)
    end
    bookings = policy_scope(Booking)
    @bookings = filter_bookings(bookings)
    @title = title
    @amount_bookings = amount_bookings(@bookings)
    @total_price = total_price(@bookings)
  end

  def show
    authorize @booking

    @room = @booking.room
    @room_price = @room.room_price
    @reduction_sentence = reduction_sentence(@booking) if @booking.reduction.negative?
  end

  def edit
    authorize @booking
  end

  def update
    authorize @booking
    @booking.user.update(first_name: params[:first_name], last_name: params[:last_name], email: params[:email])

    if @booking.update(booking_params)
      redirect_to admin_booking_path(@booking)
    else
      flash.now[:alert] = ""
      if @booking.errors.messages.values.count > 1
        @booking.errors.messages.values.each_with_index do |message, index|
          flash.now[:alert] += "#{index + 1}. #{message.first.to_s}. "
        end
      else
        flash.now[:alert] = @booking.errors.messages.values.first.first.to_s
      end
      render :edit, status: :unprocessable_entity
    end
  end

  def accept
    authorize @booking
    redirect_if_update(@booking, "acceptée")
  end

  def decline
    authorize @booking
    redirect_if_update(@booking, "refusée")
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:arrival, :departure, :guests_number, :status)
  end

  def filter_bookings(bookings)
    case params[:filter]
    when "upcoming"
      bookings.where("arrival > ?", DateTime.now).where(status: "acceptée").order("arrival ASC")
    when "past"
      bookings.where("departure < ?", DateTime.now).order("departure DESC")
    when "acceptée"
      bookings.where(status: "acceptée").order("departure DESC")
    when "en attente"
      bookings.where(status: "en attente").order("arrival ASC")
    when "refusée"
      bookings.where(status: "refusée").order("departure DESC")
    when "house"
      bookings.where(room: Room.find_by(name: "La Maison")).order("departure DESC")
    when "bedroom"
      bookings.where(room: Room.find_by(name: "La Chambre")).order("departure DESC")
    else
      bookings.order("departure DESC")
    end
  end

  def amount_bookings(bookings)
    bookings.count
  end

  def total_price(bookings)
    bookings.sum(:booking_price)
  end

  def title
    case params[:filter]
    when "upcoming"
      "Prochaines réservations"
    when "past"
      "Anciennes réservations"
    when "acceptée"
      "Réservations acceptées"
    when "en attente"
      "Réservations en attente"
    when "refusée"
      "Réservations refusées"
    when "house"
      "Réservations de la maison"
    when "bedroom"
      "Réservations de la chambre"
    else
      "Toutes les réservations"
    end
  end

  def redirect_if_update(booking, status)
    if booking.update(status: status)
      redirect_to admin_booking_path(booking)
    else
      flash.now[:alert] = booking.errors.messages.values.first.first.to_s
      render :show, status: :unprocessable_entity
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
