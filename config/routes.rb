Rails.application.routes.draw do
  # Rutas para la autenticación de usuarios
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  # Rutas para la aplicación web
  root 'users#index'
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create, :destroy] do
      resources :comments, only: [:new, :create, :destroy]
      resources :likes, only: [:create]
    end
  end

  # Rutas para la API v1
  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :show] do
        resources :posts, only: [:index, :show] do
          resources :comments, only: [:index, :create]
        end
      end
    end
  end
end
