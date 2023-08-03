require 'rails_helper'
require 'faker'

RSpec.describe 'Food', type: :feature do
  @abel = User.create!(name: Faker::Name.unique.name,
                       email: Faker::Internet.email,
                       password: '1234567', password_confirmation: '1234567')
  @shiro = Food.create(name: 'Shiro', measurement_unit: 'KG', price: 45.99, quantity: 2, user: @abel)

  describe 'food index' do
    it 'should render the food ' do
      visit '/foods'
      expect(page).to have_content('Shiro')
    end
  end

  describe 'navigation to new form' do
    it 'should take the user to new foods form page' do
      visit '/foods'
      click_link 'Add Food'
      expect(page).to have_current_path('/foods/new')
    end
  end
end