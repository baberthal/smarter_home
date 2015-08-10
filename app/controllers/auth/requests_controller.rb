module Auth
  class RequestsController < Base
    def index
      @strategies = OmniAuth.strategies
    end

    def create
      @omniauth = request.env['omniauth.auth'].to_hash
      flash.now[:notice] = "OmniAuth authentication successful."
      logger.info @omniauth.inspect
      logger.info current_user.inspect
    end

    def failure
      flash.now[:error] = "OmniAuth authentication failed."
    end
  end
end
