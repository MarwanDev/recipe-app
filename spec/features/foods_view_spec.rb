require 'rails_helper'

RSpec.describe 'Foods views', type: :feature do
  let!(:uniqueuser) { FactoryBot.create(:user, name: "uniqueuser", email: "uniqueuser@gmail.com", password: 'uniqueuserpassword', password_confirmation: 'uniqueuserpassword') }
  let!(:uniquefood) { FactoryBot.create(:food, name: 'Apple', measurement_unit: 'grams', price: 25.00, quantity: 1, user: uniqueuser) }

  describe 'food#index' do
    it 'should display all created foods' do
      visit '/foods'
      expect(page).to have_content('Apple')
    end
  end

  describe 'button to form that creates new food' do
    it 'should direct the user to the form that creates new food' do
      visit '/foods'
      click_link 'New Food'
      expect(page).to have_current_path('/foods/new')
    end
  end
end
