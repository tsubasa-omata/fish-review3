Rails.application.routes.draw do
  root 'static_pages#home'
  resources :users
  namespace :admin do
    get    'users/edit' => 'users#edit'
    delete 'users/:id' => 'users#destroy'
  end

end
