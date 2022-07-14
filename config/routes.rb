Rails.application.routes.draw do
  devise_for :users
  namespace :admin do
      resources :plants

      root to: "plants#index"
    end
  root 'home#index'
  
  resources :plants
  
  post 'add_to_garden', to: 'garden_plant#create'
  get '/people', to: 'home#people'
end
