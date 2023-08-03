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
    resources :foods, only: [:index, :show, :new, :create] do
      resources :recipe_foods, only: [:index, :show, :new, :create]
    end
    resources :recipes, only: [:index, :show, :new, :create] do
      member do
        get 'shopping_list'
      end
      resources :recipe_foods, only: [:index, :show, :new, :create] do
        member do
          get 'generate_shopping_list'
        end
      end   
    end
  end
  resources :public_recipes
end
