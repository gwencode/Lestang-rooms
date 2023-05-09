class MessageMailer < ActionMailer::Base
  default from: 'gwen.coding@gmail.com'

  def message_email
    @user = params[:user]
    @room = params[:room]
    @message = params[:message]
    mail(to: 'gwendal.lebris@hotmail.fr', subject: 'Nouveau message depuis le site Résidence Lestang')
  end
end
