class Public::RehabiliTimesController < ApplicationController
  before_action :authenticate_client!

  def new
    @rehabili_time = RehabiliTime.new
    @initial_value = "00:00:00"
    day = Time.current
    @today_rehabili_time = RehabiliTime.array_rehabili_time_of_the_day(current_client, day)
    @yesterday_rehabili_time = RehabiliTime.array_rehabili_time_of_the_day(current_client, 1.day.ago)

    # 前日比を取得
    today_rehabili_time_sec = RehabiliTime.rehabili_time_to_sec(@today_rehabili_time).to_f
    yesterday_rehabili_time_sec = RehabiliTime.rehabili_time_to_sec(@yesterday_rehabili_time).to_f
    @the_day_before_per = RehabiliTime.per_of_two_day(today_rehabili_time_sec, yesterday_rehabili_time_sec)

    @total_rehabili_time = RehabiliTime.total_rehabili_time(current_client)
  end

  def create
    rehabili_time = RehabiliTime.new(client_id: current_client.id)
    rehabili_time.record_time = rehabili_time_params[:record_time]
    rehabili_time.save
    redirect_to new_rehabili_time_path
  end

  private
  def rehabili_time_params
    params.require(:rehabili_time).permit(:record_time)
  end

end
