Rails.application.routes.draw do
  get 'user/edit' => 'users#edit'
  patch 'user/update' => 'users#update'
  get 'user' => 'users#show', as: :user

  devise_for :users, :controllers => { :omniauth_callbacks => "user_callbacks" }

  root 'users#show'
end
