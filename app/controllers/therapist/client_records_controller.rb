class Therapist::ClientRecordsController < ApplicationController
  before_action :authenticate_therapist!
  layout "therapist_application"
  def index
    @client = Client.find(params[:client_id])
    @client_menus = @client.client_menus
    # カレンダーに紐付けることを目的とし、ハッシュを生成
    @conditions = ClientRecord.gen_hash_k_record_date_v_condition(@client)
    @total_rehabili_time = RehabiliTime.total_rehabili_time(@client)
  end

  def show
    @day = params[:id].to_date
    client = Client.find(params[:client_id])
    @client_record = client.client_records.find_by(record_date: @day)
    @rehabili_time_of_the_day = @client_record.get_rehabili_time_of_the_day_for_display unless @client_record.nil?

     # 前日比を取得
    the_day_rehabili_time = RehabiliTime.array_rehabili_time_of_the_day(client, @day)
    the_day_before_rehabili_time = RehabiliTime.array_rehabili_time_of_the_day(client, @day.ago(1.days))
    the_day_rehabili_time_sec = RehabiliTime.rehabili_time_to_sec(the_day_rehabili_time).to_f
    the_day_before_rehabili_time_sec = RehabiliTime.rehabili_time_to_sec(the_day_before_rehabili_time).to_f
    @the_day_before_per = RehabiliTime.per_of_two_day(the_day_rehabili_time_sec, the_day_before_rehabili_time_sec)
  end

end
