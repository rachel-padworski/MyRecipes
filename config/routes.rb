Rails.application.routes.draw do
  root 'sessions#home'

  get '/signup' => 'users#new'
  post '/signup' => 'users#create'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'

  get '/search' => 'recipes#search'

  delete '/logout' => 'sessions#destroy'


  resources :comments
  resources :users do
    resources :recipes, only: [:new, :create, :index]
  end
  resources :recipes do
    resources :comments
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
