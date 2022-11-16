# frozen_string_literal: true

class Therapist::SessionsController < Devise::SessionsController
  layout "therapist_application"
  # before_action :configure_sign_in_params, only: [:create]
  before_action :therapist_state, only: [:create]

  def after_sign_out_path_for(resource)
     new_therapist_session_path
  end

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

   # セラピストへのサービスがすでに終了しているかを確認
  def therapist_state
    @therapist = Therapist.find_by(email: params[:therapist][:email])
    return if !@therapist
    if (@therapist.valid_password?(params[:therapist][:password])) && (@therapist.is_deleted == true)
      flash[:notice] = "退職済みのため、ご利用いただけません"
      redirect_to new_therapist_session_path
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
