Rails.application.routes.draw do

  
  root 'static_pages#home'
  get 'static_pages/about' => 'static_pages#about'
  resources :users
  #resources :likes, only: [:index]
  get 'likes/index' => 'likes#index'
  resources :reviews do
    resources :likes, only: [:create, :destroy]
  end
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :relationships, only: [:create, :destroy]
  resources :fishes, only: [:index, :show]
  resources :reviews do
    resources :comments, only: [:create, :destroy]
  end
  
  namespace :admin do
    get    'users/edit' => 'users#edit'
    delete 'users/:id' => 'users#destroy'
  end

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
 
  #get 'scrip/sc' => 'scrip#sc'
  resources :users do
    member do
      get :following, :followers
    end
  end

end

