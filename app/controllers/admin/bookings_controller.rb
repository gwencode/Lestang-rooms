class Admin::BookingsController < ApplicationController
  before_action :set_booking, only: %i[show edit update accept decline destroy]

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
    if request.path.start_with?("/admin") && !current_user.admin
      flash[:alert] = "Accès non autorisé."
      redirect_to(root_path)
      return
    end

    authorize @booking

    @room = @booking.room
    @reduction_sentence = @booking.reduction_sentence if @booking.reduction.negative?
  end

  def edit
    authorize @booking
  end

  def update
    authorize @booking
    @booking.user.update(first_name: params[:first_name], last_name: params[:last_name], email: params[:email])

    if @booking.update(booking_params)
      redirect_to admin_booking_path(@booking), notice: "Réservation modifiée"
    else
      flash.now[:alert] = @booking.errors.full_messages.join('. ')
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

  def destroy
    authorize @booking
    @booking.destroy
    redirect_to admin_bookings_path, notice: "La réservation a bien été supprimée"
  end


  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:arrival, :departure, :guests_number, :status, :comment, :paid, :refund, :refund_amount)
  end

  def filter_bookings(bookings)
    case params[:filter]
    when "upcoming"
      bookings.where("arrival > ?", DateTime.now).where(status: "acceptée").order("arrival ASC")
    when "past"
      bookings.where("departure < ?", DateTime.now).order("departure DESC")
    when "payées"
      bookings.where(status: "acceptée", paid: true).order("departure DESC")
    when "à payer"
      bookings.where(status: "acceptée", paid: false).order("departure DESC")
    when "en attente"
      bookings.where(status: "en attente").order("arrival ASC")
    when "refusée"
      bookings.where(status: "refusée").order("departure DESC")
    when "house"
      bookings.where(room: Room.find(Room.first.id)).order("departure DESC")
    when "bedroom"
      bookings.where(room: Room.find(Room.last.id)).order("departure DESC")
    else
      bookings.order("departure DESC")
    end
  end

  def amount_bookings(bookings)
    bookings.count
  end

  def total_price(bookings)
    bookings.sum(:total_price) - bookings.sum(:refund_amount)
  end

  def title
    case params[:filter]
    when "upcoming"
      "Prochaines réservations"
    when "past"
      "Anciennes réservations"
    when "payées"
      "Réservations payées"
    when "à payer"
      "Réservations à payer"
    when "en attente"
      "Réservations en attente"
    when "refusée"
      "Réservations refusées"
    when "house"
      "Réservations de la maison"
    when "bedroom"
      "Réservations des chambres"
    else
      "Toutes les réservations"
    end
  end

  def redirect_if_update(booking, status)
    if booking.update(status: status)
      redirect_to admin_booking_path(booking)
      MessageMailer.with(booking: booking, tel_admin: ENV['TEL_ADMIN']).booking_status_email.deliver_now
    else
      flash.now[:alert] = booking.errors.messages.values.first.first.to_s
      render :show, status: :unprocessable_entity
    end
  end
end
