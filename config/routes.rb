Rails.application.routes.draw do
  get '/signup',  to: 'users#new'
  resources :users, only: :create
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
end
