Rails.application.routes.draw do

  
  root 'static_pages#home'
  resources :users
  resources :reviews
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  
  namespace :admin do
    get    'users/edit' => 'users#edit'
    delete 'users/:id' => 'users#destroy'
  end

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
 
  #get 'scrip/sc' => 'scrip#sc'
end

