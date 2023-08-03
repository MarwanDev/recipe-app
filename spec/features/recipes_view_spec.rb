require 'rails_helper'

RSpec.describe 'Recipe', type: :feature do
  let(:user1) do
    User.create!(
      name: "user1",
      email: "user1@gmail.com",
      password: 'user1password',
      password_confirmation: 'user1password'
    )
  end

  before(:each) do
    assign(:recipes, [
      Recipe.create!(
        name: 'Recipe1',
        preparation_time: '30 minutes',
        cooking_time: '15 minutes',
        description: 'My yummy recipe',
        public: false,
        user: user1
      ),
      Recipe.create!(
        name: 'Recipe2',
        preparation_time: '5 minutes',
        cooking_time: '20 minutes',
        description: 'My other yummy recipe',
        public: false,
        user: user1
      )
    ])
  end

  it 'renders a list of recipes' do
    render
    expect(rendered).to match(/Recipe1/)
    expect(rendered).to match(/Recipe2/)
  end

  describe 'Recipe#show: Should display public recipes' do
    it 'should show the public recipes' do
      visit '/public_recipes'
      expect(page).to have_content('Public')
    end
  end
end