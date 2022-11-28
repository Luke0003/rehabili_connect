# frozen_string_literal: true

class Therapist::PasswordsController < Devise::PasswordsController
  before_action :authenticate_therapist!
  before_action :therapist_state, only: [:create]
  layout "therapist_application"
  # GET /resource/password/new
  # def new
  #   super
  # end

  # POST /resource/password
  # def create
  #   super
  # end

  # GET /resource/password/edit?reset_password_token=abcdef
  # def edit
  #   super
  # end

  # PUT /resource/password
  # def update
  #   super
  # end

  # protected

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end

   protected

   # セラピストへのサービスがすでに終了しているかを確認
  def therapist_state
    @therapist = Therapist.find_by(email: params[:therapist][:email])
    return if !@therapist
    if @therapist.is_deleted == true
      flash[:notice] = "退職済みのため、ご利用いただけません"
      redirect_to new_therapist_session_path
    end
  end
end
