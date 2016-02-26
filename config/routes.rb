Authentication::Engine.routes.draw do
  namespace :api do
    namespace :v1 do
      # Login and Logout
      post 'login', to: 'sessions#create'
      post 'logout', to: 'sessions#destroy'

      # Password change
      patch 'password', to: 'passwords#update'
      post 'password', to: 'passwords#forgot'

      # users
      resources :users
    end
  end
end
