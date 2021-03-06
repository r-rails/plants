Rails.application.routes.draw do
  resources :profile, only: :show
  devise_for :users

  root "home#index"

  resources :plants

  post "add_to_garden", to: "garden_plant#create"

  resources :garden_plant, only: :destroy
  get "/people", to: "home#people"
  post "/add_comment", to: "comments#create"
end
