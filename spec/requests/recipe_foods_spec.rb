# spec/requests/recipe_foods_spec.rb
require 'rails_helper'

RSpec.describe RecipeFoodsController, type: :request do
  include Devise::Test::IntegrationHelpers 

  describe 'GET #new' do
    it 'returns a successful response' do
      user = create(:user)
      recipe = create(:recipe, user: user)
      sign_in user

      get new_recipe_food_path(recipe)

      expect(response).to have_http_status(:redirect)
    end
  end

  describe 'POST #create' do
    it 'creates a new recipe_food' do
      user = create(:user)
      recipe = create(:recipe, user: user)
      # food = create(:food, meaurement_unit: 'piece') 
      sign_in user

      post new_user_food_recipe_food(recipe), params: { recipe_food: { food_id: food.id, quantity: 1 } }

      expect(response).to have_http_status(:success) 
    end
  end
end
