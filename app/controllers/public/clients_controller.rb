class Public::ClientsController < ApplicationController
  before_action :authenticate_client!
  def show
    @therapist = current_client.therapist
    @notifications_count = Notification.client_notifications_count(current_client)
  end

  def edit
  end

  def update
    if current_client.update(client_params)
      flash[:notice] = "クライアント情報が更新されました"
      redirect_to clients_my_page_path
    else
      flash[:notice] = "クライアント情報の更新に失敗しました"
      render :edit
    end
  end

  private
  def client_params
    params.require(:client).permit(:client_image, :last_name, :first_name, :last_name_kana, :first_name_kana, :purpose, :email, :prefecture)
  end
end
