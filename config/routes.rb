Authentication::Engine.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'login', to: 'sessions#create'
      post 'logout', to: 'sessions#destroy'
      resources :users
    end
  end
end
