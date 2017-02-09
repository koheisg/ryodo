Rails.application.routes.draw do
  get 'sessions/new'

  get '/signup',  to: 'users#new'
  resources :users, only: :create
end
