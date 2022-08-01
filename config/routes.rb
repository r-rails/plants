# frozen_string_literal: true

Rails.application.routes.draw do
  root "home#index"
  devise_for :users

  resources :profile, only: :show

  resources :plants do
    resources :comments, module: :plants
  end

  post "add_to_garden", to: "garden_plant#create"

  resources :garden_plant, only: :destroy
  get "/people", to: "home#people"
  # post "/add_comment", to: "comments#create"
end
