class Therapist::ChatsController < ApplicationController
  before_action :authenticate_therapist!
  layout "therapist_application"

  def show
    @client = Client.find(params[:client_id])

    if @client.room.nil?
      @room = Room.new(client_id: @client.id, therapist_id: current_therapist.id)
      @room.save
    else
      @room = @client.room
    end

    @chat = current_therapist.chats.new
    @chats = @room.chats.all
  end

  def create
    @chat = current_therapist.chats.new(chat_params)
    if @chat.save
      redirect_to therapist_client_chat_path(chat_params[:room_id], chat_params[:room_id])
    else
      @client = Client.find(params[:client_id])
      @room = @client.room
      @chats = @room.chats.all
      render :show
    end

  end

  private
  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end
end
