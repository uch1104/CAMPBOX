Rails.application.routes.draw do
  get 'cards/new'
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }
  root to: "items#index"
  resources :items do
    member do
      post 'order'
      get 'done'
    end
    collection do
      get 'search'
      get 'divide'
    end
    resource :favorites, only: [:create, :destroy]
  end
  resources :users, only: [:show, :edit, :update] do
    member do
      get 'like'
    end
  end
  resources :cards, only: [:new, :create, :show]
  resources :addresses
  resources :messages, only: [:create, :destroy]
  resources :rooms, only: [:index, :create, :show]
  resources :notifications, only: :index
end
