class Public::ClientRecordsController < ApplicationController
  before_action :authenticate_client!

  def show
    @day = params[:id].to_date
    if current_client.client_records.find_by(record_date: @day).nil?
       @client_record = current_client.client_records.new
    else
       @client_record = current_client.client_records.find_by(record_date: @day)
    end
    @client_menus = current_client.client_menus.where(start_date: @day)
    @rehabili_time_of_the_day = RehabiliTime.get_rehabili_time_of_the_day_for_record(RehabiliTime.array_rehabili_time_of_the_day(current_client, @day))
  end

  def create
    ApplicationRecord.transaction do
      @client_record = current_client.client_records.new(client_record_params)
      @client_record.save
      hash_client_menus = params[:client_menus]
      unless hash_client_menus.nil?
        ClientMenu.update_is_completed(hash_client_menus)
        ClientMenu.update_client_record_id(hash_client_menus, @client_record.id)
      end
      redirect_to root_path
    end
  rescue => e
    puts "クライアントレコードエラー: #{e}"
  end

  def update
    ApplicationRecord.transaction do
      @client_record = ClientRecord.find_by(record_date: client_record_params[:record_date])
      @client_record.update(client_record_params)
      hash_client_menus = params[:client_menus]
      ClientMenu.update_is_completed(hash_client_menus) unless hash_client_menus.nil?
      redirect_to root_path
    end
  rescue => e
    puts "クライアントレコードエラー: #{e}"
  end

  private
  def client_record_params
    params.require(:client_record).permit(:condition, :comment, :record_date, :rehabili_time_of_the_day)
  end
end
