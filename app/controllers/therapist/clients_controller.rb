class Therapist::ClientsController < ApplicationController
  before_action :authenticate_therapist!
  layout "therapist_application"
  def show
    @client = Client.find(params[:id])
  end
end
