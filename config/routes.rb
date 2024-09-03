Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  resources :airlines, only: [:show] do
    resources :policies, only: [:show] do
      resources :favorites, only: [:create, :destroy]
    end
  end

  resources :users, only: [:edit, :update]

  # Chatbot
  resources :questions, only: [:index, :create]

  get 'profile', to: "users#profile", as: :user_profile
  get 'favorites', to: "favorites#profile", as: :favorites_profile

  get 'search_airlines', to: "airlines#search", as: 'search_airlines'
  get 'search_suggestions', to: "airlines#search_suggestions"

  get 'about', to: "pages#about", as: :about

end
