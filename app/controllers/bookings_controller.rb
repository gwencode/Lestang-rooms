class BookingsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[create]
  before_action :set_user, only: %i[index show]
  before_action :set_booking, only: %i[show payment]

  def create
    @booking = Booking.new(booking_params)

    authorize @booking

    @booking.room = Room.friendly.find(params[:room_id])
    @booking.arrival = @booking.arrival.change(hour: set_hour[:arrival])
    @booking.departure = @booking.departure.change(hour: set_hour[:departure])
    @booking.status = "en attente"
    @booking.user = current_user

    if @booking.save
      redirect_to booking_path(@booking), notice: "Votre demande de réservation a bien été envoyée"
      # flash[:notice] = "Votre demande de réservation a bien été envoyée"
      MessageMailer.with(booking: @booking).booking_pending_admin_email.deliver_now
      MessageMailer.with(booking: @booking).booking_pending_user_email.deliver_now
    else
      redirect_to room_path(@booking.room), alert: @booking.errors.full_messages.join(". ")
      return
    end
  end

  def index
    # @bookings = policy_scope(Booking).order(created_at: :desc)
    @bookings = policy_scope(Booking).where(user: @user).order(created_at: :desc)
  end

  def show
    authorize @booking, :show?

    @room = @booking.room

    @reduction_sentence = @booking.reduction_sentence if @booking.reduction.negative?
  end

  def payment
    authorize @booking, :payment?

    # Créer un client dans Stripe
    customer = Stripe::Customer.create({
      payment_method: params[:payment_method_id],
      email: current_user.email,
      name: "#{current_user.first_name} #{current_user.last_name}",
      invoice_settings: {
        default_payment_method: params[:payment_method_id]
      }
    })

    # Associer le client au paiement
    session = Stripe::Checkout::Session.create(
      payment_method_types: ["card"],
      line_items: [{
        price_data: {
          currency: "eur",
          product_data: {
            name: "#{@booking.room.name}, du #{l(@booking.arrival, format: "%A %d %B")} au #{l(@booking.departure, format: "%A %d %B")}",
          },
          unit_amount: (@booking.total_price * 100).round
        },
        quantity: 1
      }],
      mode: "payment",
      # customer_email: current_user.email,
      customer: customer.id,
      success_url: booking_url(@booking),
      cancel_url: booking_url(@booking),
      payment_intent_data: {
        setup_future_usage: "off_session"
      }
    )

    @booking.update(checkout_session_id: session.id)
    redirect_to new_booking_payment_path(@booking)
  end

  private

  def set_user
    @user = current_user
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:arrival, :departure, :guests_number)
  end

  def set_hour
    case @booking.room
    when Room.first
      { arrival: 14, departure: 12 }
    when Room.last
      { arrival: 18, departure: 11 }
    end
  end
end
