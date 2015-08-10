class UserServicesController < ApplicationController
  before_action :authenticate_user!, only: :create

  def create
    @omniauth = request.env['omniauth.auth'].to_hash
    @user = if user_signed_in?
              current_user
            else
              redirect_to new_user_registration_url
            end

    update_user_service @user, @omniauth, {
      credentials: @omniauth['credentials'].to_hash,
      expires_at: convert_timestamp(@omniauth['credentials']['expires_at'])
    }

    redirect_to '/',
      flash: {
      notice: "Successfully authenticated with #{@omniauth['provider']}" }
  end

  protected
  def update_user_service user, auth_hash, options = {}
    svc = UserService.find_or_initialize_by(user_id: user.id,
                                            service: auth_hash['provider'] )
    svc.update! options
  end

  def convert_timestamp seconds_since_epoch
    unless seconds_since_epoch.nil?
      Time.at(seconds_since_epoch.to_i).to_datetime
    end
  end
end
