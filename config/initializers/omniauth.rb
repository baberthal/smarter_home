require 'omniauth/strategies/trakt'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :nest, ENV['NEST_ID'], ENV['NEST_SECRET']
  provider :trakt, ENV['TRAKT_ID'], ENV['TRAKT_SECRET'],
    strategy_class: OmniAuth::Strategies::Trakt
end

OmniAuth.config.logger = Rails.logger
