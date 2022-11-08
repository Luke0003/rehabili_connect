class Public::ClientRecordsController < ApplicationController
  def index
  end

  def show
    @day = params[:id].to_date
    @client_record = ClientRecord.new
    @client_menus = current_client.client_menus.where(start_date: @day)
  end

  def edit
  end

  def new

  end

  def create
    @client_record = current_client.client_records.new(client_record_params)
    @client_record.save
    redirect_to client_records_path
  end

  def update
  end

  # クライアントメニューの実施記録を更新
  def client_menu_update
  end

  private
  def client_record_params
    params.require(:client_record).permit(:condition, :comment, :record_date)
  end
end
