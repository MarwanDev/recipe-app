require 'rails_helper'

RSpec.describe Food, type: :model do
  describe 'associations' do
    it { should belong_to(:user).class_name('User') }
    it { should have_many(:recipe_foods).with_foreign_key('food_id') }
    it { should have_many(:recipes).through(:recipe_foods).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:user) }
  end
end
