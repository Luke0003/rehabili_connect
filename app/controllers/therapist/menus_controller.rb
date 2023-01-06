class Therapist::MenusController < ApplicationController
  before_action :authenticate_therapist!
  layout "therapist_application"
  def index
    @menus = Menu.page(params[:page])
  end

  def new
    @menu = Menu.new
  end

  def show
    @menu = Menu.find(params[:id])
  end

  def edit
    @menu = Menu.find(params[:id])
  end

  def create
    @menu = Menu.new(menu_params)
    if @menu.save
      flash[:notice] = "メニューの登録に成功しました"
      redirect_to therapist_menu_path(@menu)
    else
      flash[:notice] = "メニューの登録に失敗しました"
      render :new
    end
  end

  def update
    @menu = Menu.find(params[:id])
    if @menu.update(menu_params)
      flash[:notice] = "メニューの更新に成功しました"
      redirect_to therapist_menu_path(@menu)
    else
      flash[:notice] = "メニューの更新に失敗しました"
      render :edit
    end
  end

  def destroy
    @menu = Menu.find(params[:id])
    @menu.destroy
    flash[:notice] = "メニューを削除しました"
    redirect_to therapist_menus_path
  end

  def search
    genre_name = params[:genre_name]
    render :validater_search if genre_name.empty?
    genres = Genre.where("genre_name LIKE ?", "%#{genre_name}%")
    @menus = genres.inject(init = []){|result, genre| result + genre.menus}
  end

  private
  def menu_params
    params.require(:menu).permit(:menu_video, :menu_name, :menu_content, :menu_purpose, :genre_id)
  end
end
