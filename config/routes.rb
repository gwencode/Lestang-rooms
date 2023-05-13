Rails.application.routes.draw do
  root to: "rooms#index"

  devise_for :users
  # devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }

  resources :rooms, only: %i[show] do
    resources :bookings, only: %i[create]
  end

  resources :bookings, only: %i[index show]

  get "/localisation", to: "pages#localisation"
  get "/contact", to: "pages#contact"
  post "/contact", to: "pages#message"

  namespace :admin do
    root to: "admin#dashboard"

    resources :bookings, only: %i[index edit update destroy]
    resources :bookings, only: %i[show] do
      member do
        patch :accept
        patch :decline
      end
    end

    get "/slots", to: "admin#slots"
    get "/seasons", to: "admin#seasons"
    get "/messages", to: "admin#messages"

    resources :rooms, only: %i[index show edit update]
    resources :rooms, only: %i[show] do
      resources :seasons, except: %i[show]
      resources :slots
    end

    resources :users, only: %i[index show edit update destroy]
    resources :reviews, only: %i[index create edit update destroy]
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"
end
