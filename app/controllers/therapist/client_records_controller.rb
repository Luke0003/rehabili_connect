class Therapist::ClientRecordsController < ApplicationController
  before_action :authenticate_therapist!
  layout "therapist_application"
  def index
    @client = Client.find(params[:client_id])
    @client_records = ClientRecord.page(params[:page])
  end

  def show
    @client_record = ClientRecord.find(params[:id])
    @day = @client_record.record_date
  end

end
