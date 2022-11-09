class Therapist::TherapistsController < ApplicationController
  before_action :authenticate_therapist!
  layout "therapist_application"

  def show
  end

  def edit
  end

  def update
    if current_therapist.update(therapist_params)
      flash[:notice] = "セラピスト情報が更新されました。"
      redirect_to therapist_my_page_path
    else
      flash[:notice] = "セラピスト情報が更新されました。"
      render :edit
    end
  end

  private
  def therapist_params
    params.require(:therapist).permit(:therapist_image, :last_name, :first_name, :last_name_kana, :first_name_kana, :email)
  end

end
