# require_relative '../mailers/message_mailer'

class StripeCheckoutSessionService
  def call(event)
    booking = Booking.find_by(checkout_session_id: event.data.object.id)
    booking.update(paid: true)
    MessageMailer.with(booking: booking).booking_paid_user.deliver_now
    MessageMailer.with(booking: booking).booking_paid_admin.deliver_now
  end
end
