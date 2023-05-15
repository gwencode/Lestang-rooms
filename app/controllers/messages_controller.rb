class MessagesController < ApplicationController
  def create
    @chatroom = Chatroom.find(params[:chatroom_id])
    @message = Message.new(message_params)
    @message.chatroom = @chatroom
    @message.user = current_user
    authorize @message

    if @message.save
      ChatroomChannel.broadcast_to(
        @chatroom,
        message: render_to_string(partial: "message", locals: {message: @message}),
        sender_id: current_user.id
      )
      head :ok
      # redirect_to booking_chatroom_path(@chatroom.booking, @chatroom)
    else
      # render "chatrooms/show", status: :unprocessable_entity
      redirect_to booking_chatroom_path(@chatroom.booking, @chatroom), alert: "Le message ne peut être vide"
    end

    # if @message.save
    #   ChatroomChannel.broadcast_to(
    #     @chatroom,
    #     render_to_string(partial: "message", locals: { message: @message })
    #   )
    #   redirect_to chatroom_path(@chatroom)
    # else
    #   render "chatrooms/show", status: :unprocessable_entity
    # end

  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
