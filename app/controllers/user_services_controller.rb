class UserServicesController < ApplicationController
  include Devise::Controllers::Helpers

  def new_trakt
    redirect_to '/auth/trakt'
  end

  def new_nest
    redirect_to '/auth/nest'
  end

  def create
    @user = User.find_or_create_from_auth_hash(auth_hash)
    self.current_user = @user
    redirect_to '/'
  end

  protected
  def auth_hash
    request.env['omniauth.auth']
  end

end
