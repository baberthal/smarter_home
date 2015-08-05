class UserServicesController < ApplicationController

  def new_trakt
    redirect_to '/auth/trakt'
  end

  def new_nest
    redirect_to '/auth/nest'
  end

  def create
    state = request.params[:state]
    code = request.params[:code]
    redirect_to '/nest/token'
  end

  protected
  def auth_hash
    request.env['omniauth.auth']
  end
end
