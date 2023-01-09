class Public::RehabiliTimesController < ApplicationController
  before_action :authenticate_client!

  def new
    @rehabili_time = RehabiliTime.new
    @initial_value = "00:00:00"
    day = Time.current
    @rehabili_times = RehabiliTime.array_rehabili_time_of_the_day(current_client, day)
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
