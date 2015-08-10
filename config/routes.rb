Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  root 'static_pages#index'

  match '/auth/:provider/callback', to: 'user_services#create', via: [:get, :post]
  get '/auth/failure' => 'auth#failure'

end
