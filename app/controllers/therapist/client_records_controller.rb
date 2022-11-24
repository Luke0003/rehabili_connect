class Therapist::ClientRecordsController < ApplicationController
  before_action :authenticate_therapist!
  layout "therapist_application"
  def index
    @client = Client.find(params[:client_id])
    @client_records = @client.client_records
    @client_menus = @client.client_menus
     # キーを登録記録日、バリューを体調としたハッシュを取得
    @conditions = {}
    @client_records.each do |client_record|
      @conditions[client_record.record_date] = client_record.condition
    end
  end

  def show
    @day = params[:id].to_date
    client = Client.find(params[:client_id])
    @client_record = client.client_records.find_by(record_date: @day)
  end

end
