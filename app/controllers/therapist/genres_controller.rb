class Therapist::GenresController < ApplicationController
  before_action :authenticate_therapist!
  layout "therapist_application"
  def index
    @genre  = Genre.new
    @genres = Genre.all
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      flash[:notice] = "ジャンルの登録に成功しました"
      redirect_to therapist_genres_path
    else
      @genres = Genre.all
      flash[:notice] = "ジャンルの登録に失敗しました"
      render :index
    end
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      flash[:notice] = "ジャンルの更新に成功しました"
      redirect_to therapist_genres_path
    else
      flash[:notice] = "ジャンルの更新に失敗しました"
      render :edit
    end
  end

  def destroy
  end

  private

  def genre_params
    params.require(:genre).permit(:genre_name)
  end

end
