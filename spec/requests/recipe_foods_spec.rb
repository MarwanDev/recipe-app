require 'rails_helper'

RSpec.describe RecipeFoodsController, type: :request do
  let(:user) { User.new(name: 'Mario', email: 'mario@mario.com', password: 'password') }
  let(:food) { Food.new(name: 'bala7', meaurement_unit: 'kgs', price: 700, quantity: 20, user:) }
  let(:recipe) do
    Recipe.new(
      name: 'Recipe 1',
      description: 'desc',
      public: true,
      preparation_time: '2 hours',
      cooking_time: '2 hours',
      user:
    )
  end
  let(:recipe_food) do
    RecipeFood.new(
      quantity: 12,
      food_id: food.id,
      recipe:
    )
  end
  before do
    user.skip_confirmation!
    user.save
    post user_session_path, params: { user: { email: user.email, password: user.password } }
    follow_redirect!
    recipe.save
  end

  describe 'GET recipe#show' do
    it 'returns a successful response' do
      get user_recipe_path(user, recipe)
      expect(response).to be_successful
    end
  end

  describe 'POST recipe_food#new' do
    it 'returns a successful response' do
      get new_user_recipe_recipe_food_path(user, recipe, recipe_food)
      expect(response).to be_successful
    end
  end
end
