# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # prepend_before_action :validate_recaptchas, only: [:create]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   user_params = params[:user]
  #   first_name = user_params[:first_name]
  #   last_name = user_params[:last_name]
  #   email = user_params[:email]
  #   password = user_params[:password]
  #   password_confirmation = user_params[:password_confirmation]

  #   @user = User.new(
  #     first_name: first_name,
  #     last_name: last_name,
  #     email: email,
  #     password: password,
  #     password_confirmation: password_confirmation
  #   )

  #   if @user.valid?
  #     @valid_captcha = validate_recaptchas
  #     if @valid_captcha
  #       super
  #     else
  #       respond_with_navigational(@user) { render :new }
  #     end
  #   else
  #     super
  #   end
  # end

  # def create
  #   @user = User.new user_params
  #   @user.validate # this line will validate the user even if Recaptcha failed. This way we will present all potential validation errors right away

  #   check = verify_recaptcha action: 'signup', minimum_score: 0.1, secret_key: ENV['RECAPTCHA_SECRET_V3'] ||
  #   (verify_recaptcha model: @user, secret_key: ENV['RECAPTCHA_SECRET_V2'])

  #   if check && @user.save
  #      # everything is great, you can now let the user in and redirect them somewhere
  #      super
  #   else

  #     @user.validate # add any other validation errors

  #     # @user.validate generates a new errors, so that recaptcha error message cannot be seen.
  #     @user.errors.add(:base, t('recaptcha.errors.verification_failed')) unless check
  #     render :new # if something goes wrong, we'll re-render the form
  #   end
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # def validate_recaptchas
  #   # @v3_verify = verify_recaptcha(action: 'signup',
  #   #                              minimum_score: 1,
  #   #                              secret_key: ENV['RECAPTCHA_SECRET_KEY_V3'])
  #   v2_verify = verify_recaptcha(secret_key: ENV['RECAPTCHA_SECRET_KEY_V2'])

  #   return if v2_verify

  #   self.resource = resource_class.new sign_up_params
  #   respond_with_navigational(resource) { render :new }
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
