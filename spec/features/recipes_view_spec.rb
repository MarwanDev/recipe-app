require 'rails_helper'

RSpec.describe 'Recipe', type: :feature do
  let(:user) { User.create!(name: "Test User", email: "test@example.com", password: "testpassword") }

  describe 'Recipe#show: Should display only public recipes' do
    it 'should show the public recipes when the user is signed in' do
      # Manually set the current_user to the signed-in user
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/recipes'
      expect(page).to have_content('Public') # Modify this expectation based on the actual content of the page
    end
  end
end
