require 'rails_helper'

RSpec.describe UserServicesController, type: :controller do
  describe "omniauth callbacks" do
    context "when the user is logged in" do
      shared_examples "omniauthable" do
        before :each do
          @user = create(:user)
          @omniauth = generate_omniauth_hash provider
          request.env["omniauth.auth"] = @omniauth
          sign_in @user
        end

        describe "creating a service" do
          it 'should create the user service with the provider passed' do
            get :create, provider: provider
            @user.reload
            expect(@user.enabled_services.pluck(:service)).to include provider
          end
        end
      end

      describe "developer" do
        it_behaves_like 'omniauthable' do
          let(:provider) { "developer" }
        end
      end

      describe "nest" do
        it_behaves_like 'omniauthable' do
          let(:provider) { "nest" }
        end
      end

      describe "trakt" do
        it_behaves_like 'omniauthable' do
          let(:provider) { "trakt" }
        end
      end
    end

    context 'when the user is not logged in', type: :routing do
      it 'has no current_user' do
        expect(subject.current_user).to be nil
        expect(subject.user_signed_in?).to be false
      end
      it 'redirects to the sign_up page' do
        get :create
      end
    end
  end



describe "routing", type: :routing do# {{{
  OmniAuth.config.add_mock(:developer, {:uid => '12345'})
  it 'routes /auth/:provider/callback to user_services#create' do
    expect(:get => "/auth/developer/callback").to route_to(
      :controller => "user_services",
      :action => "create",
      :provider => "developer"
    )
  end
end# }}}

end
