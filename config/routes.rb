Rails.application.routes.draw do
  root 'pages#home' 
  get 'about', to: 'pages#about' #route /about to this action
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :articles
  # only: [:actionname, ...]
  get 'signup', to: 'users#new'
  # post 'users', to: 'users#create'

  resources :users, except: [:new]
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

end
