class Admin::BookingsController < ApplicationController

  def index
    unless current_user.admin
      flash[:alert] = "Accès non autorisé."
      redirect_to(root_path)
    end
    bookings = policy_scope(Booking)
    case params[:filter]
    when "upcoming"
      @bookings = bookings.where("start_date > ?", DateTime.now)
    when "past"
      @bookings = bookings.where("end_date < ?", DateTime.now)
    when "approved"
      @bookings = bookings.where(status: "approved")
    when "pending"
      @bookings = bookings.where(status: "pending")
    when "refused"
      @bookings = bookings.where(status: "refused")
    else
      @bookings = bookings
    end
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
end
