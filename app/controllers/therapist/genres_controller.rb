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
    @genres = Genre.all
    @genre = Genre.new(genre_params)
    render :validater_create unless @genre.save
  end

  def update
    @genres = Genre.all
    @genre = Genre.find(params[:id])
    render :validater_update unless @genre.update(genre_params)
  end

  def destroy
    @genres = Genre.all
    @genre = Genre.find(params[:id])
    @genre.destroy
  end

  private

  def genre_params
    params.require(:genre).permit(:genre_name)
  end

end
