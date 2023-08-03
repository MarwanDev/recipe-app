require 'rails_helper'

RSpec.describe 'Foods views', type: :feature do
  let!(:uniqueuser) { FactoryBot.create(:user, name: "uniqueuser", email: "uniqueuser@gmail.com", password: 'uniqueuserpassword', password_confirmation: 'uniqueuserpassword') }
  let!(:uniquefood) { FactoryBot.create(:food, name: 'Apple', meaurement_unit: 'grams', price: 25.00, quantity: 1, user: uniqueuser) }

  describe 'food#index' do
    it 'should display all created foods' do
      # Log in the user before visiting the '/foods' page
      visit login_path
      fill_in 'Email', with: uniqueuser.email
      fill_in 'Password', with: 'uniqueuserpassword'
      click_button 'Log in'
      
      visit '/foods'
      expect(page).to have_content('Apple')
    end
  end

  describe 'button to form that creates new food' do
    it 'should direct the user to the form that creates new food' do
      # Log in the user before visiting the '/foods' page
      visit login_path
      fill_in 'Email', with: uniqueuser.email
      fill_in 'Password', with: 'uniqueuserpassword'
      click_button 'Log in'

      visit '/foods'
      click_link 'New Food'
      expect(page).to have_current_path('/foods/new')
    end
  end
end
