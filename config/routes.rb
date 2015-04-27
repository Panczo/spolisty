Rails.application.routes.draw do

  devise_for :users, controllers: {
      omniauth_callbacks: "users/omniauth_callbacks",
      registrations: "users/registrations"
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
      resources :rewiews, except: [:index, :show]
    end

    resources :tracks, only: [:destroy] do
      member do
        post 'addtrack'
      end
      collection do
        get :edit_multiple
        patch :update_multiple
      end
    end

    member do 
      get :following, :followers
    end

    resources :charts
  end



  resources :relationships, only: [:create, :destroy]
  resources :genres, only: [:index, :show]
  resources :subscribes, only: [:create]
  resources :pages, only: [:index]

  get 'best_playlists', to: 'playlists#best'
  
  authenticated :user do
    root to: "users#show", :as => "profile", via: :get
  end
  
  root 'pages#index'
end
