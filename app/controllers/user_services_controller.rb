class UserServicesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :index, :manage]

  def create
    @omniauth = request.env['omniauth.auth'].to_hash
    @user = check_for_user

    update_user_service @user,
                        @omniauth,
                        credentials: @omniauth['credentials'].to_hash,
                        expires_at: convert_timestamp(@omniauth['credentials'])

    redirect_to(
      '/',
      flash: {
        notice: "Successfully authenticated with #{@omniauth['provider']}" })
  end

  def index
    @user = current_user if user_signed_in?
    @services = @user.enabled_services
  end

  def manage
    @user = current_user if user_signed_in?
    @service = @user.enabled_services.find_by(id: params[:service])
    case @service.name
    when /nest/
      @client = NestAPI::Client.new @service.credentials['token']
      @interface = Services::Nest::Interface.new(@client)
      render :nest
    end
  end

  protected

  def update_user_service(user, auth_hash, options = {})
    svc = UserService.find_or_initialize_by(user_id: user.id,
                                            service: auth_hash['provider'])
    svc.update! options
  end

  def convert_timestamp(object_to_convert)
    case object_to_convert
    when Fixnum
      Time.at(object_to_convert.to_i).utc
    when Hash
      Time.at(object_to_convert['expires_at'].to_i).utc
    end
  end

  def check_for_user
    if user_signed_in?
      current_user
    else
      redirect_to new_user_registration_url
    end
  end
end
