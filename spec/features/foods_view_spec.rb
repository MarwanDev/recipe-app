require 'rails_helper'

RSpec.feature 'Foods', type: :system do
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
  end

  describe '#index' do
    before(:each) do
      visit user_foods_path(@user)
    end
    it 'should display food' do
      expect(page).to have_content(@food1.name)
      expect(page).to have_content(@food1.meaurement_unit)
      expect(page).to have_content(@food1.price)
      expect(page).to have_content('Foods')
      expect(page).to have_content('New food')
      expect(page).to have_content('Actions')
      expect(page).to have_content('Unit Price')
      expect(page).to have_content('Meaurement Unit')
      expect(page).to have_content('Name')
    end
  end
end
