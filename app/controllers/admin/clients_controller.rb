class Admin::ClientsController < ApplicationController
  before_action :authenticate_admin!
  layout "admin_application"
  def index
    @clients = Client.page(params[:page])
  end

  def show
    @client = Client.find(params[:id])
  end

  def edit
    @client = Client.find(params[:id])
  end

  def update
    @client = Client.find(params[:id])
    if @client.update(client_params)
      flash[:notice] = "クライアント情報の更新に成功しました"
      redirect_to admin_client_path(@client)
    else
      flash[:notice] = "クライアント情報の更新に失敗しました"
      render :edit
    end
  end

  private
  def client_params
    params.require(:client).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :purpose, :email, :is_deleted)
  end
end
