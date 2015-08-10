module Services
  class NestController < ApplicationController
    def create
      @user = current_user
      @auth = UserServices.find_or_create_by(user_id: @user.id,
                                             service: 'nest').credentials
      @client = Nest.new @auth, { user: @user }
    end

  end
end
