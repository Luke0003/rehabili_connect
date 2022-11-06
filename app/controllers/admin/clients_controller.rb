class Admin::ClientsController < ApplicationController
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
      redirect_to admin_client_path(@client)
    end
  end

  private
  def client_params
    params.require(:client).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :is_deleted)
  end
end
