require 'rails_helper'
require 'faker'

RSpec.describe 'Foods views', type: :feature do
  let(:user) { User.create!(name: "Test User", email: "test@example.com", password: "testpassword") }

  before(:each) do
    # Manually set the current_user to the signed-in user
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

  describe 'food#index' do
    it 'should display all created foods for the current user' do
      # Create some foods for the user
      food1 = Food.create(name: 'Apple', meaurement_unit: 'grams', price: 25.00, quantity: 1, user: user)
      food2 = Food.create(name: 'Banana', meaurement_unit: 'grams', price: 15.00, quantity: 2, user: user)

      visit '/foods'

      # Now, test the content on the page
      expect(page).to have_content('Apple')
      expect(page).to have_content('Banana')
    end
  end

  describe 'button to form that creates new food' do
    it 'should direct the user to the form that creates new food' do
      visit '/foods'
      click_link 'New Food'
      expect(page).to have_current_path(new_food_path)
    end
  end
end
