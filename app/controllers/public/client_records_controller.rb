class Public::ClientRecordsController < ApplicationController
  before_action :authenticate_client!
  def index
    @client_menus = current_client.client_menus
    @client_records = current_client.client_records
    # キーを登録記録日、バリューを体調としたハッシュを取得
    @conditions = {}
    @client_records.each do |client_record|
      @conditions[client_record.record_date] = client_record.condition
    end
  end

  def show
    @day = params[:id].to_date

    @client_record = ClientRecord.find_by(record_date: @day)
    @client_record = ClientRecord.new if @client_record.nil?
    @client_menus = current_client.client_menus.where(start_date: @day)
  end

  def create
    @client_record = current_client.client_records.new(client_record_params)
    @client_record.save

    # check_box_tagのデータをkey, valueで分けて繰り返し、
    # ClientMenuのis_completedを更新する
    params[:client_menus].each do |key, value|
      ClientMenu.find(key).update(is_completed: value, client_record_id: @client_record.id)
    end

    redirect_to client_records_path
  end

  def update
    @client_record = ClientRecord.find_by(record_date: client_record_params[:record_date])
    @client_record.update(client_record_params)
    params[:client_menus].each do |key, value|
      ClientMenu.find(key).update(is_completed: value,  client_record_id: @client_record.id)
    end
    redirect_to client_records_path
  end

  private
  def client_record_params
    params.require(:client_record).permit(:condition, :comment, :record_date)
  end
end
