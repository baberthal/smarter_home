require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Trakt < OmniAuth::Strategies::OAuth2
      option :name, "Trakt.tv"

      option :client_options, {
        site: "https://api-v2launch.trakt.tv",
        authorize_url: "https://private-anon-78f1e79af-trakt.apiary-mock.com",
        token_url: "/oauth/token"
      }

    end
  end
end
