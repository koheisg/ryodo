Rails.application.routes.draw do
  get '/signup',  to: 'users#new'
  get '/github/authorize/callback/signup', to: 'users#create'
  get '/me/edit', to: 'users#edit'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  resources :articles, except: %i(delete)
  resources :tags
  resources :article_tags, only: %i(destroy)
  get '/articles/tags/:id', to: 'articles/tags#index', as: 'articles_tags'
  namespace :github do
    get 'authorize/new'
    get 'authorize/callback', to: 'authorize#create'
    resources :repositories, only: %i(new create)
  end
end
