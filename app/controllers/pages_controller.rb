class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[localisation contact message]

  def localisation
    @markers = [
      { lat: 43.668226,
        lng: 1.498332,
        info_window_html: render_to_string(partial: "info_window"),
        marker_html: render_to_string(partial: "marker")
        }
      ]

    add_breadcrumb "Localisation", :localisation_path
  end

  def contact
    @user = current_user ? current_user : User.new
    @rooms = Room.all

    add_breadcrumb "Contact", :contact_path
  end

  def message
    user = current_user ? current_user : User.new
    if current_user.nil?
      user.email = user_params[:email]
      user.first_name = user_params[:first_name]
      user.last_name = user_params[:last_name]
    end
    room = Room.friendly.find(params[:room].to_i)
    message = params[:message]
    check = verify_recaptcha action: 'message', minimum_score: 0.7, secret_key: ENV['RECAPTCHA_SECRET_KEY']
    if check && user.email.present? && user.first_name.present? && user.last_name.present? && message.present?
      MessageMailer.with(user: user, room: room, message: message).contact_admin_email.deliver_now
      MessageMailer.with(user: user, room: room, message: message).contact_user_email.deliver_now
      redirect_to root_path, notice: "Votre message a bien été envoyé."
    else
      @user = current_user ? current_user : User.new
      @rooms = Room.all
      redirect_to contact_path, alert: "Veuillez remplir tous les champs."
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name)
  end
end
