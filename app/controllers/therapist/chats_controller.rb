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
    @notifications = current_therapist.notifications.where(client_id: params[:client_id])
    @notifications.each do |notification|
      if notification.checked_therapist == false
        notification.update(checked_therapist: true)
      end
    end
  end

  def create
    @chat = current_therapist.chats.new(chat_params)
    render :validater unless @chat.save
    @notification = current_therapist.notifications.create(chat_id: @chat.id, client_id: params[:client_id], checked_therapist: true)
  end

  private
  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end
end
