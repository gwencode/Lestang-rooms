class ChatroomsController < ApplicationController
  def show
    @chatroom = Chatroom.find(params[:id])
    authorize @chatroom
    @message = Message.new
    @booking = @chatroom.booking
    @room = @booking.room
  end

  def index
    chatrooms_with_messages = policy_scope(Chatroom).joins(:messages).order('messages.created_at DESC').uniq
    chatrooms_without_messages = policy_scope(Chatroom).left_outer_joins(:messages).where(messages: { id: nil }).order(created_at: :desc)

    @chatrooms = chatrooms_with_messages.union(chatrooms_without_messages)
  end
end
