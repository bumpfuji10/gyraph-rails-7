Rails.application.routes.draw do

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  root "pages#home"
  get "/signup", to: "users#new"
  resources :users, only: [:new, :create, :show, :index, :edit, :update]
  get "/account_confirmation/:token", to: "users#confirm", as: "account_confirmation"
  resources :practice_records

  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  get "logout", to: "sessions#destroy"
  delete "logout", to: "sessions#destroy"
end
