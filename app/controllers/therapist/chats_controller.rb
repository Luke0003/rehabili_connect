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
    Notification.change_from_unread_to_read_for_therapist(current_therapist, @client)
  end

  def create
    ApplicationRecord.transaction do
      @chat = current_therapist.chats.new(chat_params)
      @chat.save!
      @notification = current_therapist.notifications.new(chat_id: @chat.id, client_id: params[:client_id], checked_therapist: true)
      @client = Client.find(params[:client_id])
      ActionCable.server.broadcast 'chat_channel', {user: "therapist", chat_partner_name: @client.full_name, content: @chat, created_at: @chat.created_at.strftime('%m/%d %H:%M')} if @notification.save!
    end
  rescue => e
    puts "セラピストチャットエラー: #{e}"
    @client = Client.find(params[:client_id])
    @room = @client.room
    @chats = @room.chats.all
    render :show
  end

  private
  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end
end
