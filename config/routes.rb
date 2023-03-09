Rails.application.routes.draw do
  devise_for :users
  root to: "rooms#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :rooms, only: [:show] do
    resources :bookings, only: [:create]
  end

  get "/localisation", to: "pages#localisation"
  get "/contact", to: "pages#contact"
end
