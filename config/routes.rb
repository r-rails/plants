# frozen_string_literal: true

Rails.application.routes.draw do
  mount Motor::Admin => '/motor_admin'
  root "home#index"
  devise_for :users

  resources :profile, only: [:show], param: :slug

  resources :plants do
    resources :comments, module: :plants
  end

  post "add_to_garden", to: "garden_plant#create"
  resources :garden_plant, only: :destroy
  
  get "/people", to: "home#people"
end
