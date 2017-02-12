Rails.application.routes.draw do
  get 'auth/callback'

  get '/signup',  to: 'users#new'
  resources :users, only: :create
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  get '/auth/github/callback', to: 'auth#callback'
  get '/auth/github/token', to: 'auth#access_token'
  get '/auth', to: 'auth#new'
end
