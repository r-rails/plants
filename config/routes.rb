# frozen_string_literal: true

Rails.application.routes.draw do
  mount Motor::Admin => "/motor_admin"
  root "home#index"
  devise_for :users

  resources :profile, only: [:show], param: :slug

  resources :plants do
    resources :comments, module: :plants
    get :category_hovercard
    get :gardenplant_hovercard
  end

  get "/top_ten_plants", to: "plants#top_ten_plants"
  get "/most_recent_plants", to: "plants#most_recent_plants"
  get "/plants_category", to: "plants#plants_category"

  post "add_to_garden", to: "garden_plant#create"
  resources :garden_plant, only: :destroy

  get "/people", to: "home#people"
  get "/top_growers", to: "home#top_growers"
end
