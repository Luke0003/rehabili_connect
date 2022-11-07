class Therapist::ClientsController < ApplicationController
  layout "therapist_application"
  def show
    @client = Client.find(params[:id])
  end
end
