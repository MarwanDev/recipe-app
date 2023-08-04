Rails.application.routes.draw do
  devise_for :users
  root "users#show"
  resources :recipes
  resources :recipe_foods
  resources :foods
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/") 
  resources :users, only: [:index, :show, :new, :create] do
    resources :foods, only: [:index, :show, :new, :create, :destroy] do
      resources :recipe_foods, only: [:index, :show, :new, :create, :destroy]
    end
    resources :recipes, only: [:index, :show, :new, :create, :destroy] do
      resources :recipe_foods, only: [:index, :show, :new, :create, :destroy] do
      end
      resources :shopping_list, only: [:index, :show, :new, :create]
    end
  end
  post 'shopping_list/recipe_id=:recipe_id', to: 'recipes#generate_shopping_list', as: 'generate_shopping_list'
  get 'shopping_list/recipe_id=:recipe_id', to: 'recipes#generate', as: "shopping_list"
  resources :public_recipes
end
