# frozen_string_literal: true

Rails.application.routes.draw do
  get "notifications/index"
  mount Motor::Admin => "/motor_admin"
  root "home#index"
  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks",
    sessions: "users/sessions",
    registrations: "users/registrations"
  }

  resources :profile, only: [:show], param: :slug
  get "update_status", to: "profile#update_status"

  resources :plants do
    resources :comments, module: :plants
    get :category_hovercard
    get :gardenplant_hovercard
  end

  get "/top_ten_plants", to: "plants#top_ten_plants"
  get "/most_recent_plants", to: "plants#most_recent_plants"
  get "/plants_category", to: "plants#plants_category"

  post "add_to_garden", to: "garden_plant#create"
  delete "garden_plant", to: "garden_plant#destroy"

  get "/people", to: "home#people"
  get "/top_growers", to: "home#top_growers"

  resources :notifications, only: [:index]
  delete "delete_notification", to: "notifications#destroy"
  get "set_to_read", to: "notifications#set_to_read"
  get "set_to_unread", to: "notifications#set_to_unread"
end
