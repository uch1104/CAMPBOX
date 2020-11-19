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
  end
  resources :users, only: [:show, :edit, :update]
  resources :cards, only: [:new, :create, :show]
  resources :addresses, only: [:new, :create, :show]
end
