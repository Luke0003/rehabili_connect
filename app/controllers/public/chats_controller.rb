class Public::ChatsController < ApplicationController
  before_action :authenticate_client!
  def show
    @therapist = current_client.therapist

    if current_client.room.nil?
      @room = Room.new(client_id: current_client.id, therapist_id: @therapist.id)
      @room.save
    else
      @room = current_client.room
    end

    @chat = current_client.chats.new
    @chats = @room.chats.all
  end

  def create
    @chat = current_client.chats.new(chat_params)
    render :validater unless @chat.save
  end

  private
  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end
end
