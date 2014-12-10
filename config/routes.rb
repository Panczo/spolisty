Rails.application.routes.draw do

  devise_for :users, controllers: {
      omniauth_callbacks: "users/omniauth_callbacks" 
    }

  resources :users, only: [:show]
  resources :subscribes, only: [:create]
  resources :pages, only: [:index]

  root 'pages#index'

end
