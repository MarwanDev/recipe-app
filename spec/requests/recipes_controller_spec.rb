require 'rails_helper'

RSpec.describe ShoppingListController, type: :controller do
  describe 'GET #show' do
    let(:recipe) { create(:recipe) } 

    before do
      firstfood = create(:food)
      secondfood = create(:food)

      let!(:recipe_firstfood) { create(:recipe_food, recipe: recipe, food: firstfood, quantity: 2) }
      let!(:recipe_secondfood) { create(:recipe_food, recipe: recipe, food: secondfood, quantity: 3) }

      get :show, params: { recipe_id: recipe.id }
    end

    it 'assigns the correct recipe' do
      expect(assigns(:recipe)).to eq(recipe)
    end

    it 'assigns all recipe_food records' do
      expect(assigns(:recipe_food)).to eq([recipe_firstfood, recipe_secondfood])
    end

    it 'assigns all food records' do
      expect(assigns(:food)).to match_array([recipe_firstfood.food, recipe_secondfood.food])
    end

    it 'calculates the total price correctly' do
      total_price = (recipe_firstfood.quantity * recipe_firstfood.food.price) + (recipe_secondfood.quantity * recipe_secondfood.food.price)
      expect(assigns(:total_price)).to eq(total_price)
    end

    it 'renders the show template' do
      expect(response).to render_template(:show)
    end
  end
end
