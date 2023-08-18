Rails.application.routes.draw do
  # after_sign_in_path_for
  # after_sign_out_path_for
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  root 'users#index'
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create, :destroy] do
      resources :comments, only: [:new, :create, :destroy]
      resources :likes, only: [:create]

    end
  end
end