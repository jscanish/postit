PostitTemplate::Application.routes.draw do
  root to: 'posts#index'

  resources :posts, except: :destroy do
    resources :comments, only: :create
  end


  resources :categories, only: [:index, :new, :create, :show]
end

