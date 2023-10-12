# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  prepend_before_action :validate_recaptchas, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  def validate_recaptchas
    v3_verify = verify_recaptcha(action: 'login',
                                 minimum_score: 1,
                                 secret_key: ENV['RECAPTCHA_SECRET_KEY_V3'])
    v2_verify = verify_recaptcha(secret_key: ENV['RECAPTCHA_SECRET_KEY_V2'])

    p "_________________________________________________________"
    p "v3_verify: #{v3_verify}"
    p "v2_verify: #{v2_verify}"
    p "_________________________________________________________"
    return if v3_verify || v2_verify

    self.resource = resource_class.new sign_in_params
    respond_with_navigational(resource) { render :new }
  end
end
