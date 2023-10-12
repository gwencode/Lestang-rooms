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
    @user = current_user || User.new
    @rooms = Room.all

    add_breadcrumb "Contact", :contact_path
  end

  def message
    user = current_user || User.new
    if current_user.nil?
      user.email = user_params[:email]
      user.first_name = user_params[:first_name]
      user.last_name = user_params[:last_name]
    end
    room = Room.friendly.find(params[:room].to_i)
    message = params[:message]
    v2_verify = verify_recaptcha(secret_key: ENV['RECAPTCHA_SECRET_KEY_V2'])
    p "_________________________________________________________"
    p "v2_verify: #{v2_verify}"
    p "_________________________________________________________"

    if user.email.blank? || user.first_name.blank? || user.last_name.blank? || message.blank?
      @user = current_user || User.new
      @rooms = Room.all
      redirect_to contact_path, alert: "Veuillez remplir tous les champs."
    elsif v2_verify
      MessageMailer.with(user: user, room: room, message: message).contact_admin_email.deliver_now
      MessageMailer.with(user: user, room: room, message: message).contact_user_email.deliver_now
      redirect_to root_path, notice: "Votre message a bien été envoyé."
    else
      redirect_to contact_path, alert: "Veuillez cocher le captcha."
    end

    # Captcha v3
    # v3_verify = verify_recaptcha action: 'message', minimum_score: 0.7, secret_key: ENV['RECAPTCHA_SECRET_KEY_V3']
    # if (v3_verify || v2_verify) && user.email.present? && user.first_name.present? && user.last_name.present? && message.present?
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name)
  end
end
