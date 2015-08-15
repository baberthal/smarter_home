require 'rails_helper'

RSpec.describe UserServicesController, type: :controller do
  describe 'omniauth callbacks' do # {{{
    context 'when the user is logged in' do
      let(:omniauth) { generate_omniauth_hash provider }
      let(:user) { create(:user) }

      shared_examples 'omniauthable' do
        before :each do
          request.env['omniauth.auth'] = omniauth
          sign_in user
        end

        describe 'creating a service' do
          it 'creates the user service with the provider passed' do
            get :create, provider: provider
            user.reload
            expect(user.enabled_services.pluck(:service)).to include provider
          end
        end
      end

      describe 'developer' do
        it_behaves_like 'omniauthable' do
          let(:provider) { 'developer' }
        end
      end

      describe 'nest' do
        it_behaves_like 'omniauthable' do
          let(:provider) { 'nest' }
        end
      end

      describe 'trakt' do
        it_behaves_like 'omniauthable' do
          let(:provider) { 'trakt' }
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
  end # }}}

  describe 'routing', type: :routing do # {{{
    OmniAuth.config.add_mock(:developer, uid: '12345')
    it 'routes /auth/:provider/callback to user_services#create' do
      expect(get: '/auth/developer/callback')
        .to route_to(
          controller: 'user_services',
          action: 'create',
          provider: 'developer')
    end
  end # }}}

  context 'when a user is logged in' do
    login_user

    shared_examples 'authenticatable' do
      it 'assigns user to the current user' do
        expect(assigns(:user)).to eq user
      end
    end

    describe '#index' do
      before :each do
        create_list(:user_service, 5, user: user)
        get :index
      end

      it_behaves_like 'authenticatable'

      it 'assigns services the the current users services' do
        expect(assigns(:services)).to eq user.enabled_services
        expect(user.enabled_services.length).to eq 5
      end
    end

    describe '#manage' do
      let(:service) { create(:user_service, service: 'nest', user: user) }
      let(:client_double) { instance_double('NestAPI::Client') }
      let(:iface) { instance_double('Services::Nest::Interface') }

      before :each do
        allow(NestAPI::Client).to receive(:new).and_return(client_double)
        allow(Services::Nest::Interface).to receive(:new).and_return(iface)
        get :manage, service: service.id
      end

      it_behaves_like 'authenticatable'

      it 'finds the service' do
        expect(assigns(:service)).to eq service
      end

      it 'routes to the nest service' do
        expect(assigns(:client)).to eq client_double
        expect(assigns(:interface)).to eq iface
      end
    end
  end

  context 'when a user is not logged in' do
    describe 'index' do
      before :each do
        get :index
      end

      it 'redirects to the login page' do
        expect(response.status).to eq 302
      end
    end
  end
end
