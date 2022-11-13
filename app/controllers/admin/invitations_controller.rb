class Admin::InvitationsController < Devise::InvitationsController
  # Devise::InvitationsControllerの中で
  # prepend_before_action :authenticate_inviter!, only: [:new, :create]が記述されていて、
  # セラピストがログインしていないと招待メールが送れない問題を解消
  skip_before_action :authenticate_inviter!, only: [:new, :create]
  before_action :authenticate_inviter_admin!, only: [:new, :create]
  before_action :configure_permitted_parameters
  layout "admin_application"

  def new
    super
  end

  def create
    super
  end

  def edit
    super
  end

  def update
    super
  end

  def destroy
    super
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:invite, keys: [:first_name, :last_name, :first_name_kana, :last_name_kana])
  end

  # 管理者がログインしているかを確認
  def authenticate_inviter_admin!
    send(:"authenticate_admin!", force: true)
  end

end