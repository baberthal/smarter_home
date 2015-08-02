class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def nest
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication
      set_flash_message(:notice, :success, :kind => "Nest") if is_navigational_format?
    else
      session["devise.nest_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  private
  def request_params(code)
    ActionController::Parameters.new({
      code: code,
      client_id: ENV['NEST_CLIENT_ID'],
      client_secret: ENV['NEST_CLIENT_SECRET']
    })
  end

  def nest_request(code)
    uri = URI.parse("http://api.home.nest.com/oauth2/access_token")
    params = request_params(code)

    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.request_uri)
    request.set_form_data(params)
    response = http.request(request)
    response
  end
end
