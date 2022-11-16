# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :client_state, only: [:create]

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

  # クライアントへのサービスがすでに終了しているかを確認
  def client_state
    @client = Client.find_by(email: params[:client][:email])
    return if !@client
    if (@client.valid_password?(params[:client][:password])) && (@client.is_deleted == true)
      flash[:notice] = "サービスは終了いたしました"
      redirect_to new_client_session_path
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
