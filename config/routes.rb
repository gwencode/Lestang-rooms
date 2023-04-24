Rails.application.routes.draw do
  root to: "rooms#index"

  devise_for :users
  # devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :rooms, only: %i[show] do
    resources :bookings, only: [:create]
  end

  get "/localisation", to: "pages#localisation"
  get "/contact", to: "pages#contact"

  namespace :admin do
    root to: "admin#dashboard"
    resources :bookings, only: %i[index show update]
    get "/slots", to: "admin#slots"
    get "/messages", to: "admin#messages"
    resources :rooms, only: %i[index show edit update]
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"
end
