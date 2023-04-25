class Admin::BookingsController < ApplicationController

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
    @booking = Booking.find(params[:id])
    authorize @booking
  end

  def update
    @booking = Booking.find(params[:id])
    authorize @booking
    @booking.update(booking_params)
    redirect_to admin_bookings_path
  end

  private

  def booking_params
    params.require(:booking).permit(:status, :start_date, :end_date)
  end

  def filter_bookings(bookings)
    case params[:filter]
    when "upcoming"
      bookings.where("start_date > ?", DateTime.now).order("start_date ASC")
    when "past"
      bookings.where("end_date < ?", DateTime.now).order("end_date DESC")
    when "approved"
      bookings.where(status: "approved").order("end_date DESC")
    when "pending"
      bookings.where(status: "pending").order("start_date ASC")
    when "refused"
      bookings.where(status: "refused").order("end_date DESC")
    when "house"
      bookings.where(room: Room.find_by(name: "La Maison")).order("end_date DESC")
    when "bedroom"
      bookings.where(room: Room.find_by(name: "La Chambre")).order("end_date DESC")
    else
      bookings.order("end_date DESC")
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
    when "approved"
      "Réservations acceptées"
    when "pending"
      "Réservations en attente"
    when "refused"
      "Réservations refusées"
    when "house"
      "Réservations de la maison"
    when "bedroom"
      "Réservations de la chambre"
    else
      "Toutes les réservations"
    end
  end
end
