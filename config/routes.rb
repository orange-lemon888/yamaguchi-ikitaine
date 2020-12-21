Rails.application.routes.draw do
  root to: 'posts#index'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:show, :new, :create]
  resources :posts
end
