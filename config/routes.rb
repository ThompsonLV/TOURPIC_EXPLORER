Rails.application.routes.draw do
  devise_for :users
  root to: "monuments#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get 'users/sign_in'

  resources :monuments, only: %i[index show]

  resources :questions, only: :show

  resources :users, only: %i[index]
  get "my_profil", to: "users#my_profil"

  resources :user_answers, only: %i[create]
end
