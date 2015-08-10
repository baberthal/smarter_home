class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def trakt
    @user = User.find_for_trakt(request.env["omniauth.auth"], current_user)

    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Trakt Oauth"
      sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.trakt"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
end
