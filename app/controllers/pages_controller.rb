class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[localisation contact message]

  def localisation
    @localisation_infos_content = Content.find_by(name: "localisation_infos")
    @moving_around_content = Content.find_by(name: "moving_around")
    @markers = [
      { lat: 43.668226,
        lng: 1.498332,
        info_window_html: render_to_string(partial: "info_window"),
        marker_html: render_to_string(partial: "marker")
        }
      ]
    @url_pictures = UrlPicture.where(page: "localisation")

    add_breadcrumb "Localisation", :localisation_path
  end

  def contact
    @before_booking_title_content = Content.find_by(name: "before_booking_title")
    @before_booking_description_content = Content.find_by(name: "before_booking_description")
    @contact_form_title_content = Content.find_by(name: "contact_form_title")
    @contact_form_description_content = Content.find_by(name: "contact_form_description")
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

    if user.email.blank? || user.first_name.blank? || user.last_name.blank? || message.blank?
      @user = user
      @rooms = Room.all
      render :contact
    elsif validate_recaptchas
      MessageMailer.with(user: user, room: room, message: message).contact_admin_email.deliver_now
      MessageMailer.with(user: user, room: room, message: message).contact_user_email.deliver_now
      redirect_to root_path, notice: "Votre message a bien été envoyé."
    else
      render :contact_form
    end

  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name)
  end

  def validate_recaptchas
    v3_verify = verify_recaptcha(action: 'contact',
                                 minimum_score: 0.7,
                                 secret_key: ENV['RECAPTCHA_SECRET_KEY_V3'])
    v2_verify = verify_recaptcha(secret_key: ENV['RECAPTCHA_SECRET_KEY_V2'])

    return v3_verify || v2_verify
    # self.resource = resource_class.new sign_in_params
    # respond_with_navigational(resource) { render :new }
  end
end
