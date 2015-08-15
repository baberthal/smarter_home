require 'rest-client'
require 'json'

module Trakt
  class Client
    attr_reader :resource
    def initialize(omniauth_auth_hash, options = {})
      @headers = {
        content_type: 'application/json',
        authorization: "Bearer #{omniauth_auth_hash['token']}",
        trakt_api_version: '2',
        trakt_api_key: ENV['TRAKT_ID']
      }
      @base_url = options[:url] || 'https://api-v2launch.trakt.tv'
      @resource = RestClient::Resource.new "#{@base_url}",
                                           headers: @headers
    end

    def get(resource_uri)
      rubify @resource[resource_uri].get
    end

    def new_shows(days, start_date = nil)
      start_date ||= today
      get "/calendas/my/shows/new/#{start_date}/#{days}"
    end

    def shows(days, start_date = nil)
      start_date ||= today
      get "/calendars/my/shows/#{start_date}/#{days}"
    end

    def season_premiers(days, start_date = nil)
      start_date ||= today
      get "/calendars/my/shows/premieres/#{start_date}/#{days}"
    end

    def movies(days, start_date = nil)
      start_date ||= today
      get "/calendars/my/movies/#{start_date}/#{days}"
    end

    def all_shows(days, start_date = nil)
      start_date ||= today
      get "/calendars/all/shows/#{start_date}/#{days}"
    end

    def all_new_shows(days, start_date = nil)
      start_date ||= today
      get "/calendars/all/shows/new/#{start_date}/#{days}"
    end

    def all_season_premiers(days, start_date = nil)
      start_date ||= today
      get "/calendars/all/shows/premieres/#{start_date}/#{days}"
    end

    def all_movies(days, start_date = nil)
      start_date ||= today
      get "/calendars/all/movies/#{start_date}/#{days}"
    end

    private

    def rubify(json)
      JSON.parse(json)
    end

    def today
      Time.zone.today.to_s
    end
  end
end
