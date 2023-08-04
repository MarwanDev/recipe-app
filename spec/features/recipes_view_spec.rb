require 'rails_helper'

RSpec.feature 'Recipes', type: :system do
  include Devise::Test::IntegrationHelpers
  before do
    @user = User.create(
      name: 'Marwan',
      email: 'user@example.com',
      password: 'password',
      confirmed_at: '2023-08-01 13:46:21.825849',
      confirmation_sent_at: '2023-08-01 13:46:18.95477'
    )

    sign_in @user

    @recipe1 =
      Recipe.create(
        name: 'Recipe 1',
        description: 'desc',
        public: true,
        preparation_time: '2 hours',
        cooking_time: '2 hours',
        user: @user
      )
  end


  describe '#index' do
    before(:each) do
      visit user_recipes_path(@user)
    end
    it 'should display recipe' do
      expect(page).to have_content(@recipe1.name)
      expect(page).to have_content(@recipe1.description)
      expect(page).to have_content('Remove')
      expect(page).to have_content('New recipe')
      # show
      visit user_recipe_path(@user, @recipe1)
      expect(current_path).to eq(user_recipe_path(@user, @recipe1))
      expect(page).to have_content(@recipe1.name)
      expect(page).to have_content(@recipe1.description)
      expect(page).to have_content(@recipe1.preparation_time)
      expect(page).to have_content(@recipe1.cooking_time)
      expect(page).to have_content('Add ingredient')
      expect(page).to have_content('Generate shopping list')
    end
  end
end
