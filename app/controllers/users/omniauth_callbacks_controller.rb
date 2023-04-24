class Users::OmniauthCallbacksController < ApplicationController
  # def calendly
  #   auth = request.env['omniauth.auth']
  #   raise
  #   user = User.from_omniauth(auth)
  #   if user.persisted?
  #     sign_in_and_redirect user, event: :authentication
  #   else
  #     session['devise.calendly_data'] = auth
  #     redirect_to new_user_registration_url
  #   end
  # end

  # def failure
  #   redirect_to root_path
  # end
end
