require 'rails_helper'

RSpec.describe 'Foods views', type: :feature do
  @user1 = User.create!(name: "user1",
                        email: "user1@gmail.com",
                        password: 'user1password', password_confirmation: 'user1password')
  @food1 = Food.create(name: 'Apple', measurement_unit: 'grams', price: 25.00, quantity: 1, user: @user1)

  describe 'food#index' do
    it 'should display all created foods ' do
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