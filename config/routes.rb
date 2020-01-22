Rails.application.routes.draw do
  root 'static_pages#home'
  get 'static_pages/about' => 'static_pages#about'
  resources :users do
    resources :relationships, only: [:create, :destroy]
    member do
      get :following, :followers
    end
  end
  #resources :likes, only: [:index]
  get 'likes/index' => 'likes#index'
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :fishes, only: [:index, :show] do
    resources :reviews do
      resources :comments, only: [:create, :destroy]
      resources :likes, only: [:create, :destroy]
    end
  end
  
  namespace :admin do
    resources :users, only: [:edit, :destroy]
  end

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
end

