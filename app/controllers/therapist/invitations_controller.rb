class Therapist::InvitationsController < Devise::InvitationsController
  # Devise::InvitationsControllerの中で
  # prepend_before_action :authenticate_inviter!, only: [:new, :create]が記述されていて、
  # クライアントがログインしていないと招待メールが送れない問題を解消
  skip_before_action :authenticate_inviter!
  skip_before_action :has_invitations_left?
  before_action :authenticate_inviter_therapist!, only: [:new, :create]
  before_action :configure_permitted_parameters
  layout "therapist_application"

  def new
    super
  end

  def create
    self.resource = client_invite_resource
    resource_invited = resource.errors.empty?

    yield resource if block_given?

    if resource_invited
      if is_flashing_format? && self.resource.invitation_sent_at
        set_flash_message :notice, :send_instructions, email: self.resource.email
      end
      if self.method(:after_invite_path_for).arity == 1
        respond_with resource, location: after_invite_path_for(current_inviter)
      else
        redirect_to therapist_root_path
      end
    else
      respond_with_navigational(resource) { render :new }
    end
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
    devise_parameter_sanitizer.permit(:invite, keys: [:first_name, :last_name, :first_name_kana, :last_name_kana, :therapist_id, :purpose, :admin_id])
  end

  # セラピストがログインしているかを確認
  def authenticate_inviter_therapist!
    send(:"authenticate_therapist!", force: true)
  end

  def client_invite_resource(&block)
    resource_class.invite!(invite_params, therapist_inviter, &block)
  end

  def therapist_inviter
    authenticate_inviter_therapist!
  end

end