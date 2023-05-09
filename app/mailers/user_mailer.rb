class UserMailer < ApplicationMailer
  default from: 'gwen.coding@gmail.com'

  def welcome_email
    @user = params[:user]
    @url = 'http://localhost:3000/users/sign_in'
    mail(to: @user.email, subject: 'Bienvenue sur Résidence Lestang !')
  end

  def message_email
    @user = params[:user]
    @room = params[:room]
    @message = params[:message]
    mail(to: 'gwendal.lebris@hotmail.fr', subject: 'Nouveau message depuis le site Résidence Lestang')
  end
end
