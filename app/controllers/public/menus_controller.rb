class Public::MenusController < ApplicationController
  before_action :authenticate_client!
  def show
     @menu = Menu.find(params[:id])
  end
end
