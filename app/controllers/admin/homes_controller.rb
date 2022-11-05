class Admin::HomesController < ApplicationController
  layout "admin_application"
  def top
    @therapists = Therapist.page(params[:page])
  end
end
