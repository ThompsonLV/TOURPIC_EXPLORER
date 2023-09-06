Rails.application.routes.draw do
  devise_for :users
  root to: "monuments#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # get 'users/sign_in'

  resources :monuments, only: %i[index show] do
    resources :questions, only: %i[index show]
    resources :user_monuments, only: %i[index create]
    get 'map', on: :member
  end

  # resources :users, only: %i[index]
  get "my_profil", to: "users#my_profil"
  get "parameters", to: "users#parameters"
  resources :user_answers, only: %i[create]
  resources :user_monuments, only: :update

  get "/distance", to: "monuments#distance_between"
end
