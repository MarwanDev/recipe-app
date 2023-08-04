require 'rails_helper'

RSpec.feature 'Foods', type: :feature do
  before do
    @user = User.create(email: 'user@example.com', password: 'password')

    @food1 = Food.create(name: 'Food 1', meaurement_unit: 'grams', price: 10)
    @food2 = Food.create(name: 'Food 2', meaurement_unit: 'pieces', price: 5)
  end

  scenario 'Viewing food index and food show' do
    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: 'password'
    click_button 'Log in'
    
    expect(page).to have_current_path(root_path)

    visit foods_path
    expect(page).to have_content('Foods')
    expect(page).to have_selector('table')
    expect(page).to have_selector('thead th', text: 'Name')
    expect(page).to have_selector('thead th', text: 'Measurement Unit')
    expect(page).to have_selector('thead th', text: 'Unit Price')

    expect(page).to have_selector('tr', count: 3) 

    expect(page).to have_selector('button', text: 'New food')
    expect(page).to have_link('Edit this food', count: 2)
    expect(page).to have_button('Delete', count: 2)

    # Step 5: Visit the food show page
    visit food_path(@food1)

    # Step 6: Check for the presence of elements on the show page
    expect(page).to have_content('Food 1')
    expect(page).to have_content('grams')
    expect(page).to have_content('10')

    # Step 7: Check for the presence of links on the show page
    expect(page).to have_link('Edit this food')
    expect(page).to have_link('Back to foods')
    expect(page).to have_button('Destroy this food')
  end
end
