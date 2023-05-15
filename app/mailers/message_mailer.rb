class MessageMailer < ActionMailer::Base
  default from: ENV['SENDMAIL_USERNAME']

  def contact_admin_email
    @user = params[:user]
    @room = params[:room]
    @message = params[:message]
    mail(to: ENV['ADMIN_EMAIL_1'], subject: 'Nouveau message depuis le site Résidence Lestang')
  end

  def contact_user_email
    @user = params[:user]
    @room = params[:room]
    @message = params[:message]
    mail(to: @user.email, subject: 'Résidence Lestang - Demande de renseignements envoyée')
  end

  def booking_pending_admin_email
    @booking = params[:booking]
    @room = @booking.room
    @user = @booking.user
    mail(to: ENV['ADMIN_EMAIL_1'], subject: "Résidence Lestang - Demande de réservation pour #{@room.name}")
  end

  def booking_pending_user_email
    @booking = params[:booking]
    @room = @booking.room
    @user = @booking.user
    mail(to: @user.email, subject: "Résidence Lestang - Demande de réservation envoyée")
  end

  def booking_status_email
    @booking = params[:booking]
    @tel_admin = params[:tel_admin]
    @room = @booking.room
    @user = @booking.user
    @status = @booking.status
    mail(to: @user.email, subject: "Résidence Lestang - Demande de réservation #{@status}")
  end
end
