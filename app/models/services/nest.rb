require 'nest_api/client'

module Services
  class Nest
    attr_accessor :auth, :user, :client
    def initialize auth, options = {}
      @auth = auth
      @user ||= options[:user]
      @client = NestAPI::Client.new @auth["token"]
    end
  end
end
