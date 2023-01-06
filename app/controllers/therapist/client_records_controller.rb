class Therapist::ClientRecordsController < ApplicationController
  before_action :authenticate_therapist!
  layout "therapist_application"
  def index
    @client = Client.find(params[:client_id])
    @client_menus = @client.client_menus
    # カレンダーに紐付けることを目的とし、ハッシュを生成
    @conditions = ClientRecord.gen_hash_k_record_date_v_condition(@client)
  end

  def show
    @day = params[:id].to_date
    client = Client.find(params[:client_id])
    @client_record = client.client_records.find_by(record_date: @day)
  end

end
