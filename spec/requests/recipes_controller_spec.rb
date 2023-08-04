require 'rails_helper'

RSpec.describe RecipesController, type: :request do
  let(:user) { User.new(name: 'Mario', email: 'mario@mario.com', password: 'password') }
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
  before do
    user.skip_confirmation!
    user.save
    post user_session_path, params: { user: { email: user.email, password: user.password } }
    follow_redirect!
    recipe.save
  end

  describe 'GET recipe#index' do
    it 'returns a successful response' do
      get user_recipes_path(user)
      expect(response).to be_successful
    end
  end

  describe 'POST recipe#new' do
    it 'returns a successful response' do
      get new_user_recipe_path(user)
      expect(response).to be_successful
    end
  end

  describe 'DELETE recipe#destroy' do
    it 'returns a successful response' do
      delete user_recipe_path(user, recipe.id)
      expect(response).to redirect_to(user_recipes_path(user))
    end
  end
end
