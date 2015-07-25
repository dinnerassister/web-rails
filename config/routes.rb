Rails.application.routes.draw do
  resources :plans
  root 'recipes#index'

  get 'recipes/tags/:name' => 'search#tags'
  get 'recipes/all' => 'search#all'
  get 'user/recipes' => 'search#user'

  resources :recipes
  
  devise_for :users, :controllers => { :omniauth_callbacks => "user_callbacks" }

  get 'user/edit' => 'users#edit'
  patch 'user/update' => 'users#update'
  get 'user' => 'users#show', as: :user

  post 'meal/recipe/:recipe_id' => 'meal_recipes#add_recipe'
  delete 'meal/recipe/:recipe_id' => 'meal_recipes#delete_recipe'
  post 'meal/recipes' => 'meal_recipes#add'
  delete 'meal/recipes' => 'meal_recipes#delete'



  get 'static_pages/about'
  get 'static_pages/howto'

end
