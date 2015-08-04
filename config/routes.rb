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

  post 'maindish/recipe/:recipe_id' => 'main_dish_recipes#add_recipe'
  delete 'maindish/recipe/:recipe_id' => 'main_dish_recipes#delete_recipe'
  post 'maindish/recipes' => 'main_dish_recipes#add'
  delete 'maindish/recipes' => 'main_dish_recipes#delete'



  get 'static_pages/about'
  get 'static_pages/howto'

end
