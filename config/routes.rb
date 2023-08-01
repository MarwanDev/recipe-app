Rails.application.routes.draw do
  root "users#index"
  resources :recipes
  resources :recipe_foods
  resources :foods
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/") 
end
