Rails.application.routes.draw do
  root to: "rooms#index"

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resources :rooms, only: %i[show] do
    resources :bookings, only: %i[create]
  end

  resources :bookings, only: %i[index show] do
    member do
      patch :payment
    end
    resources :payments, only: :new

    resources :chatrooms, only: %i[show] do
      resources :messages, only: :create
    end
    resources :chatrooms, only: %i[create]
  end

  mount StripeEvent::Engine, at: '/webhook'

  # resources :chatrooms, only: %i[index]
  get "/messages", to: "chatrooms#index"

  get "/localisation", to: "pages#localisation"
  get "/contact", to: "pages#contact"
  post "/contact", to: "pages#message"

  namespace :admin do
    root to: "admin#dashboard"

    resources :contents, only: %i[edit update]

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
    get "/rooms/:id/edit_room_contents", to: "rooms#edit_room_contents", as: "edit_room_contents"
    patch "/rooms/:id/update_contents", to: "rooms#update_room_contents", as: "update_room_contents"
    get "/rooms/:id/edit_room_pictures", to: "rooms#edit_room_pictures", as: "edit_room_pictures"
    patch "/rooms/:id/update_room_pictures", to: "rooms#update_room_pictures", as: "update_room_pictures"

    resources :rooms, only: %i[show] do
      resources :seasons, except: %i[show]
      resources :slots
    end

    resources :users, only: %i[index show edit update destroy]
    resources :reviews, only: %i[index create edit update destroy]
    resources :pictures, only: %i[index edit update]
    resources :url_pictures, only: %i[edit update]
  end

  match "/404", to: "errors#not_found", via: :all
  match "/422", to: "errors#unacceptable", via: :all
  match "/500", to: "errors#internal_server_error", via: :all

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"
end
