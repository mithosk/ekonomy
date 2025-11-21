Rails.application.routes.draw do
  root "home#index"

  get "balancing", to: "balancing#index"

  get "category", to: "category#index"

  get "dashboard", to: "dashboard#index"

  get "detection", to: "detection#index"

  get "expense", to: "expense#index"
end
