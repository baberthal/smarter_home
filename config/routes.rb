Rails.application.routes.draw do
  devise_for :users
  root 'static_pages#index'
  get '/connect/trakt' => 'user_services#new_trakt', as: :connect_trakt
  get '/connect/nest' => 'user_services#new_nest', as: :connect_nest

  scope module: 'auth' do
    get '/test/index' => 'requests#index', as: :omniauth_test
    match '/auth/:provider/callback', to: 'callbacks#create', via: [:get, :post]
    get '/auth/failure' => 'requests#failure'
  end



end
