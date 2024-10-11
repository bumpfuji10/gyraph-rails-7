Rails.application.routes.draw do

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  root "pages#home"
  get "/signup", to: "users#new"
  resources :users, only: [:new, :create, :show, :index, :edit, :update]
  get "/account_activations/:token", to: "account_activations#edit", as: "account_activation"
  resources :practice_records
  get '/calendars', to: 'calendars#show', as: 'calendar'

  get "password/forgot", to: "user_password_resets#new"
  post "password/forgot", to: "user_password_resets#create"
  get "password/reset/:token", to: "user_password_resets#edit", as: "password_reset"
  patch "password/reset/:token", to: "user_password_resets#update"

  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  get "logout", to: "sessions#destroy"
  delete "logout", to: "sessions#destroy"
end
