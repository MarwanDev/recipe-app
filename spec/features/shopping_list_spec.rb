require 'rails_helper'

RSpec.feature 'Shopping list', type: :system do
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

    @food1 =
      Food.create(
        name: 'Food 1',
        meaurement_unit: 'grams',
        price: 10,
        user: @user
      )

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

  describe 'shopping list' do
    before(:each) do
      visit user_recipe_shopping_list_path(@user, @recipe1, @recipe1)
    end
    it 'should display shopping list' do
      expect(page).to have_content('Shopping List')
      expect(page).to have_content('Amount of food items to buy:')
      expect(page).to have_content('Total price:')
      expect(page).to have_content('Food')
      expect(page).to have_content('Quantity')
      expect(page).to have_content('Price')
    end
  end
end
