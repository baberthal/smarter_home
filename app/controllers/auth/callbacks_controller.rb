module Auth
  class CallbacksController < Base
    def create
      @omniauth = request.env['omniauth.auth'].to_hash
      @user = if current_user
                current_user
              else
                User.find_or_create_by(email: @omniauth['uid'])
              end
      logger.info @user.inspect
      logger.info @omniauth.inspect

      @user_service = UserService.find_or_create_by(user_id: @user.id, service: @omniauth['provider']) do |svc|
        svc.credentails = @omniauth['credentials']
        svc.save!
      end

      redirect_to '/',
        flash: {
          notice: "Successfully authenticated with #{@omniauth['provider']}" }
    end
  end
end
