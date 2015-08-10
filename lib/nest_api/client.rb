require 'firebase'

module NestAPI
  class Client
    attr_reader :firebase

    def initialize token
      base_uri = "https://developer-api.nest.com"
      @firebase = Firebase::Client.new base_uri, token
    end

    def structures
      @firebase.get '/'
    end

    def devices
      @firebase.get '/devices'
    end

    def device device_id, device_type = thermostats
      @firebase.get "/devices/#{device_type}/#{device_id}"
    end
  end
end
