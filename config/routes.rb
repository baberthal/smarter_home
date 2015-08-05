Rails.application.routes.draw do
  devise_for :users
  root 'static_pages#index'
  get '/auth/:provider/callback', to: 'user_services#create'
  get '/connect/trakt' => 'user_services#new_trakt', as: :connect_trakt
  get '/connect/nest' => 'user_services#new_nest', as: :connect_nest
end
