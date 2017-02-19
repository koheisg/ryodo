Rails.application.routes.draw do
  get '/signup',  to: 'users#new'
  get '/me/edit', to: 'users#edit'
  resources :users, only: %i(create)
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  resources :articles, except: %i(show delete)
  namespace :github do
    get 'authorize/new'
    get 'authorize/callback', to: 'authorize#create'
  end
end
