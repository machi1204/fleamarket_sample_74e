Rails.application.routes.draw do
  # get 'orders/index', to: 'orderss#index'
  # get 'orders/done'
  get 'card/new'
  get 'card/show'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  devise_scope :user do
    get  'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end

  root 'items#index'
  resources :users
  resources :items, except: [:index] do
    resources :comments, only: :create
    collection do
      get 'category_children', defaults: {format: 'json'}
      get 'category_grandchildren', defaults: {format: 'json'}
      get 'get_size', defaults: {format: 'json'}
    end
    resources :orders, only: [:index]
    post 'pay', to: 'orders#pay'
    get 'done', to: 'orders#done'
    collection do
      get 'set_images'
    end
  end


  resources :card, only: [:new, :show] do
    collection do
      post 'show', to: 'card#show'
      post 'pay', to: 'card#pay'
      post 'delete', to: 'card#delete'
    end
  end
end


