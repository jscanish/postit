PostitTemplate::Application.routes.draw do
  root to: 'posts#index'

  get "/register", to: 'users#new'
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "logout", to: "sessions#destroy"
  get "/profile", to: "sessions#show"

  resources :posts, except: :destroy do
    member do
      post 'vote'
    end
    resources :comments, only: :create do
      member do
        post 'vote'
      end
    end
  end

  resources :users, only: [:create, :show]
  resources :categories, only: [:new, :create, :show]
end


