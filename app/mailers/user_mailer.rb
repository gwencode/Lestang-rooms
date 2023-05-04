class UserMailer < ApplicationMailer
  default from: 'gwen.coding@gmail.com'

  def welcome_email
    @user = params[:user]
    @url = 'http://localhost:3000/users/sign_in'
    mail(to: @user.email, subject: 'Bienvenue sur Résidence Lestang !')
  end
end
