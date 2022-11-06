class Admin::TherapistsController < ApplicationController
  layout "admin_application"

  def show
    @therapist = Therapist.find(params[:id])
  end

  def edit
    @therapist = Therapist.find(params[:id])
  end

  def update
    @therapist = Therapist.find(params[:id])
    if @therapist.update(therapist_params)
      flash[:notice] = "セラピスト情報の更新に成功しました"
      redirect_to admin_therapist_path(@therapist)
    else
      flash[:notice] = "セラピスト情報の更新に失敗しました"
      render :edit
    end
  end

  private
  def therapist_params
    params.require(:therapist).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :is_deleted)
  end
end
