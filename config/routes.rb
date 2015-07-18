Rails.application.routes.draw do
  root 'recipes#index'

  get 'recipes/tags/:name' => 'search#tags'
  get 'recipes/all' => 'search#all'  

  resources :recipes
  
  devise_for :users, :controllers => { :omniauth_callbacks => "user_callbacks" }

  get 'user/edit' => 'users#edit'
  patch 'user/update' => 'users#update'
  get 'user' => 'users#show', as: :user


  get 'static_pages/about'

  get 'static_pages/howto'

end
