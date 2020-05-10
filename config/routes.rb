Rails.application.routes.draw do
  get 'root/index'
  devise_for :users
  root 'root#index'
  resources :root, only: [:index]
  resources :users
  resources :items, except: [:index]
end
