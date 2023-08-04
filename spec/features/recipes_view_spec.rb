require 'rails_helper'

RSpec.describe 'Recipe', type: :feature do
  let(:user) { User.create!(name: 'Test User', email: 'test@example.com', password: 'testpassword') }

  describe 'Recipe#show: Should display only public recipes' do
    it 'should show the public recipes when the user is signed in' do
      # Manually set the current_user to the signed-in user
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      # Create some sample recipes (replace this with your actual recipe creation logic)
      public_recipe = Recipe.create(name: 'Public Recipe', preparation_time: '10 mins', cooking_time: '30 mins', description: 'A public recipe', public: true)
      private_recipe = Recipe.create(name: 'Private Recipe', preparation_time: '15 mins', cooking_time: '20 mins', description: 'A private recipe', public: false)

      visit user_recipes_path(user)

      # Check if the public recipe is displayed on the index page
      expect(page).to have_content('Public Recipe')

      # Click on the public recipe link to visit the show page
      click_link 'Public Recipe'

      # Check for the presence of elements on the show page
      expect(page).to have_content('Public Recipe')
      expect(page).to have_content('10 mins')
      expect(page).to have_content('30 mins')
      expect(page).to have_content('A public recipe')

      # Check if the "Generate shopping list" and "Add ingredient" buttons are present
      expect(page).to have_link('Generate shopping list')
      expect(page).to have_link('Add ingredient')
    end
  end
end
