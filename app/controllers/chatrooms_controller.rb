class ChatroomsController < ApplicationController
  # def index
  #   @user = current_user
  #   @chatrooms = Chatroom
  # end

  def show
    @chatroom = Chatroom.find(params[:id])
  end
end
