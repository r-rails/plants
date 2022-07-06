Rails.application.routes.draw do
  namespace :admin do
      resources :plants

      root to: "plants#index"
    end
  root 'home#index'

  get '/plants', to: 'home#plants'
  get '/users', to: 'home#users'
end
