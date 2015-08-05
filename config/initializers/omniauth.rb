require 'omniauth/strategies/trakt'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :nest, ENV['NEST_CLIENT_ID'], ENV['NEST_CLIENT_SECRET']
  provider :trakt, ENV['TRAKT_CLIENT_ID'], ENV['TRAKT_CLIENT_SECRET']
end

OmniAuth.config.logger = Rails.logger
