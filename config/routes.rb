Rails.application.routes.draw do
  get '/signup',  to: 'users#new'
  resources :users, only: :create
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/posts', to: 'articles#index'
  get '/posts/new', to: 'articles#new'
  post '/posts', to: 'articles#create'
end
