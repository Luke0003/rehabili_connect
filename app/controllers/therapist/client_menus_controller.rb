class Therapist::ClientMenusController < ApplicationController
  before_action :authenticate_therapist!
  layout "therapist_application"
  def index
    @client = Client.find(params[:client_id])
    @client_menu = ClientMenu.new
    @client_menus = @client.client_menus.page(params[:page])
  end

  def edit
    @client = Client.find(params[:client_id])
    @client_menu = ClientMenu.find(params[:id])
  end

  def create
    @client_menus = ClientMenu.page(params[:page])
    @client = Client.find(params[:client_id])
    @client_menu_start_date = client_menu_params[:start_date]
    @client_menu_finsh_date = params[:finish_date][:finish_date]
    # 開始日が終了日と同じに日にちになるまで繰り返し保存
    # 保存に失敗した場合は繰り返し処理を抜け、エラーメッセージを返す
    if @client_menu_start_date <= @client_menu_finsh_date
      while  @client_menu_start_date <= @client_menu_finsh_date do
        @client_menu = ClientMenu.new(menu_id: client_menu_params[:menu_id], start_date: @client_menu_start_date)
        @client_menu.client_id = @client.id
        break render :validater_create unless @client_menu.save
        @client_menu_start_date = (@client_menu_start_date.to_date + 1).to_s
      end
    else
      @client_menu = ClientMenu.new(client_menu_params)
      @client_menu.errors[:base] <<  "終了日が不適切です"
      render :validater_create
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
    @client_menus = ClientMenu.page(params[:page])
    @client = Client.find(params[:client_id])
    @client_menu = ClientMenu.find(params[:id])
    @client_menu.destroy
  end

  def search
    @date = params[:start_date].to_date
    @client = Client.find(params[:client_id])
    @client_menus = Kaminari.paginate_array(@client.client_menus.where(start_date: @date)).page(params[:page])
  end

  private
  def client_menu_params
    params.require(:client_menu).permit(:menu_id, :start_date)
  end
end
