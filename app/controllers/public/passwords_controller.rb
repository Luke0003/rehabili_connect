# frozen_string_literal: true

class Public::PasswordsController < Devise::PasswordsController
  before_action :authenticate_client!
  before_action :client_state, only: [:create]

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

  # クライアントへのサービスがすでに終了しているかを確認
  def client_state
    @client = Client.find_by(email: params[:client][:email])
    return if !@client
    if @client.is_deleted == true
      flash[:notice] = "サービスは終了いたしました"
      redirect_to new_client_session_path
    end
  end
end
