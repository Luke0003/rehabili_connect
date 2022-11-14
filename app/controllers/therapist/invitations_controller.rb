class Therapist::InvitationsController < Devise::InvitationsController
  # Devise::InvitationsControllerの中で
  # prepend_before_action :authenticate_inviter!, only: [:new, :create]が記述されていて、
  # クライアントがログインしていないと招待メールが送れない問題を解消
  skip_before_action :authenticate_inviter!, only: [:new, :create]
  before_action :authenticate_inviter_therapist!, only: [:new, :create]
  # before_action :authenticate_admin!, only: [:new, :create]
  before_action :configure_permitted_parameters
  layout "therapist_application"

  def new
    super
  end

  def create
    print(2222222222222)
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
    devise_parameter_sanitizer.permit(:invite, keys: [:first_name, :last_name, :first_name_kana, :last_name_kana, :therapist_id, :purpose])
  end

  # セラピストがログインしているかを確認
  def authenticate_inviter_therapist!
    send(:"authenticate_therapist!", force: true)
  end

end