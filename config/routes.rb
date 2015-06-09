Rails.application.routes.draw do
  resources :recipes
  get 'user/edit' => 'users#edit'
  patch 'user/update' => 'users#update'
  get 'user' => 'users#show', as: :user

  devise_for :users, :controllers => { :omniauth_callbacks => "user_callbacks" }

  root 'recipes#index'
end
