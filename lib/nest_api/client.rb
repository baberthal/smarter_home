require 'firebase'

module NestAPI
  Response = Struct.new(:status, :body)

  class Client
    attr_reader :firebase, :structures, :devices, :last_call

    def initialize(token)
      base_uri = 'https://developer-api.nest.com'
      @firebase = Firebase::Client.new base_uri, token
      @response = _query_backend('/')
      return unless @response[:status] == 200
      @devices = @response[:body]['devices']
      @structures = @response[:body]['structures']
    end

    def query_structures
      return @structures unless can_make_call?
      @structures = _query_backend('/').body['stuctures']
      @structures
    end

    def query_devices
      return @structures unless can_make_call?
      @devices = _query_backend('/devices').body
      @devices
    end

    def query_device(device_id, device_type = thermostats)
      return unless can_make_call?
      _query_backend("/devices/#{device_type}/#{device_id}").body
    end

    private

    def _format_response
      response = yield
      update_last_call
      result = Response.new(response.code, response.body)
      result
    end

    def update_last_call
      @last_call = Time.now.utc
    end

    def _query_backend(resource)
      _format_response { @firebase.get("#{resource}") }
    end

    def can_make_call?
      (Time.now.now.utc - 90.seconds.ago.utc) >= 0
    end
  end
end
