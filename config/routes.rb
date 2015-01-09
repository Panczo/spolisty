Rails.application.routes.draw do

  devise_for :users, controllers: {
      omniauth_callbacks: "users/omniauth_callbacks" 
    }

  resources :users, only: [:show] do
  	resources :playlists do
      collection do
        get 'import'
      end
      member do
        get 'export'
      end
    end
    resources :tracks, only: [:addtrack] do
      member do
        post 'addtrack'
      end
    end
  end

  resources :subscribes, only: [:create]
  resources :pages, only: [:index]

  root 'pages#index'

end
