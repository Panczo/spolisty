Rails.application.routes.draw do

  devise_for :users, controllers: {
      omniauth_callbacks: "users/omniauth_callbacks" 
    }

  devise_scope :user do
    get "/login" => "devise/sessions#new"
  end

  resources :users, only: [:index, :show] do
  	resources :playlists do
      collection do
        get 'import'
      end
      member do
        get 'export'
      end
    end
    resources :tracks, only: [:destroy] do
      member do
        post 'addtrack'
      end
    end
    resources :charts
  end

  resources :subscribes, only: [:create]
  resources :pages, only: [:index]

  get 'spotify_genres/index'
  
  root 'pages#index'

end
