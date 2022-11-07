class Therapist::ClientMenusController < ApplicationController
  layout "therapist_application"
  def index
    @client = Client.find(params[:client_id])
    @client_menu = ClientMenu.new
    @client_menus = ClientMenu.page(params[:page])
  end

  def edit
    @client = Client.find(params[:client_id])
    @client_menu = ClientMenu.find(params[:id])
  end

  def create
    @client = Client.find(params[:client_id])
    @client_menu = ClientMenu.new(client_menu_params)
    @client_menu.client_id = @client.id
    if @client_menu.save
      flash[:notice] = "クライアントメニューの登録に成功しました"
      redirect_to therapist_client_client_menus_path
    else
      flash[:notice] = "クライアントメニューの登録に失敗しました"
      @client = Client.find(params[:client_id])
      @client_menus = ClientMenu.page(params[:page])
      render :index
    end
  end

  def update
    @client_menu = ClientMenu.find(params[:id])
    if @client_menu.update(client_menu_params)
      flash[:notice] = "クライアントメニューの更新に成功しました"
      redirect_to therapist_client_client_menus_path
    else
      flash[:notice] = "クライアントメニューの更新に失敗しました"
       @client = Client.find(params[:client_id])
      render :edit
    end
  end

  def destroy
    @client_menu = ClientMenu.find(params[:id])
    @client_menu.destroy
    flash[:notice] = "クライアントメニューを削除しました"
    redirect_to therapist_client_client_menus_path
  end

  private
  def client_menu_params
    params.require(:client_menu).permit(:menu_id, :start_date)
  end
end
