Rails.application.routes.draw do
  get "balancing", to: "balancing#index"

  get "category", to: "category#index"

  get "dashboard", to: "dashboard#index"

  get "detection", to: "detection#index"

  get "expense", to: "expense#index"

  root "home#index"

  post "user/authenticate", to: "user#authenticate"
  post "user/create", to: "user#create"
  get "user/detail/:id", to: "user#detail"
  post "user/edit/:id", to: "user#edit"
  get "user", to: "user#index"
  get "user/sign-in", to: "user#sign_in"
  get "user/sign-up", to: "user#sign_up"
end
