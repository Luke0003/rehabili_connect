class Therapist::ClientsController < ApplicationController
  before_action :authenticate_therapist!
  layout "therapist_application"
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
      redirect_to therapist_client_path(@client)
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
