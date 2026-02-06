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
  get "user", to: "user#index"
  post "user/save/:id", to: "user#save"
  get "user/sign-in", to: "user#sign_in"
  get "user/sign-up", to: "user#sign_up"

  get "year/detail/:id", to: "year#detail"
  get "year", to: "year#index"
  post "year/save/:id", to: "year#save"
end
