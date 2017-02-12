Rails.application.routes.draw do
  get '/signup',  to: 'users#new'
  resources :users, only: %i(create edit show)
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  resources :articles, except: %i(show delete)
  namespace :github do
    get 'authorize/new'
    get 'authorize/callback'
    get 'authorize/access_token'
  end
end
