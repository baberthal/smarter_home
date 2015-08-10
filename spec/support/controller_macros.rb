module ControllerMacros

  def login_user
    before :each do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryGirl.create(:user)
      sign_in user
    end
  end

  def login_user_with_omniauth
    before :each do
      user = FactoryGirl.create(:user)
      sign_in user
      OmniAuth.config.add_mock(:developer, {:uid => '12345' })
    end
  end

  def create_mock_auth provider
    OmniAuth.config.mock_auth[:prov] = OmniAuth::AuthHash.new({
      :provider => "#{provider}",
      :uid => Faker::Internet.email,
      :credentials => { authorization_code: Faker::Number.hexadecimal(25) }
    })
  end

  def mock_failure provider
    OmniAuth.config.mock_auth[provider] = :invalid_credentials
  end

  def cleanup_omniauth
  end
end
