Rails.application.routes.draw do
  root to: "rooms#index"

  devise_for :users

  resources :rooms, only: %i[show] do
    resources :bookings, only: [:create]
  end

  get "/localisation", to: "pages#localisation"
  get "/contact", to: "pages#contact"

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
    get "/messages", to: "admin#messages"

    resources :rooms, only: %i[index show edit update]
    resources :rooms, only: %i[show] do
      resources :seasons
    end

  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"
end
