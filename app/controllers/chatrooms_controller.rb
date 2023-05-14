class ChatroomsController < ApplicationController
  def show
    @chatroom = Chatroom.find(params[:id])
    authorize @chatroom
    @message = Message.new
    @booking = @chatroom.booking
    @room = @booking.room
    @user = current_user
  end
end
