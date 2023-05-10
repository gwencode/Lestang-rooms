class MessageMailer < ActionMailer::Base
  default from: ENV['SENDMAIL_USERNAME']

  def contact_email
    @user = params[:user]
    @room = params[:room]
    @message = params[:message]
    mail(to: 'gwendal.lebris@hotmail.fr', subject: 'Nouveau message depuis le site Résidence Lestang')
  end

  def booking_pending_admin_email
    @booking = params[:booking]
    @room = @booking.room
    @user = @booking.user
    mail(to: 'gwendal.lebris@hotmail.fr', subject: "Résidence Lestang - Demande de réservation pour #{@room.name}")
  end

  def booking_pending_user_email
    @booking = params[:booking]
    @room = @booking.room
    @user = @booking.user
    mail(to: @user.email, subject: "Résidence Lestang - Demande de réservation envoyée")
  end
end
