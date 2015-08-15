Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  root 'static_pages#index'

  match '/auth/:provider/callback',
        to: 'user_services#create',
        via: [:get, :post]

  get '/auth/failure' => 'auth#failure'

  get '/my/services' => 'user_services#index'
  get '/my/services/:service' => 'user_services#manage', as: :manage_service
end
