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
    @notifications = current_client.notifications
    @notifications.each do |notification|
      if notification.checked_client == false
        notification.update(checked_client: true)
      end
    end
  end

  def create
    ApplicationRecord.transaction do
      @chat = current_client.chats.new(chat_params)
      @chat.save!
      @notification = current_client.notifications.new(chat_id: @chat.id, therapist_id: current_client.therapist.id, checked_client: true)
      @notification.save!
    end
  rescue => e
    puts "クライアントチャットエラー: #{e}"
    render :validater
  end

  private
  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end
end
