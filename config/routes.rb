Rails.application.routes.draw do
  devise_for :users
  root 'item#index'
  resources :users
  resources :items, except: [:index]
end
