Rails.application.routes.draw do
  devise_for :users
  namespace :admin do
      resources :plants

      root to: "plants#index"
    end
  root 'home#index'
  
  resources :plants
  get '/people', to: 'home#people'
end
