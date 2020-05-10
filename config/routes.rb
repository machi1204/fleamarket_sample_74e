Rails.application.routes.draw do
  devise_for :users
  root 'root#index'
  resources :root, only: [:index]
  resources :users
  resources :items, except: [:index]
end
