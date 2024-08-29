Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  resources :airlines, only: [:show]

  resources :users, only: [:edit, :update]

  get 'profile', to: "users#profile"

  # policies MVC
  resources :policies, only: [:show]
  get 'airlines/:id/policies/:id', to: "policies#show", as: :airline_policy

  get 'search_airlines', to: "airlines#search", as: 'search_airlines'
  get 'search_suggestions', to: "airlines#search_suggestions"
end
