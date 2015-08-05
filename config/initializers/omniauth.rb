Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :nest, ENV['NEST_CLIENT_ID'], ENV['NEST_CLIENT_SECRET']

end
