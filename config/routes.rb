Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"
    get "/static_pages/home"
    get "/static_pages/help"
    
    get "sessions/new"
    get "sessions/create"
    get "sessions/destroy"
    
    get "/signup", to: "users#new"
    post "/signup", to: "users#create"

    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"

    resources :users do 
      member do 
        get :following, :followers
      end
    end
    
    resources :users
    resources :account_activations, only: :edit
    resources :password_resets, only: %i(new create edit update)
    resources :microposts, only: %i(create destroy)
    resources :relationships,only: %i(create destroy)
  
  end
end
