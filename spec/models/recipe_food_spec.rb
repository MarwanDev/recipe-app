# spec/models/recipe_food_spec.rb
require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  describe 'associations' do
    it { should belong_to(:food).class_name('Food').with_foreign_key('food_id') }
    it { should belong_to(:recipe).class_name('Recipe').with_foreign_key('recipe_id') }
  end

  describe 'validations' do
    it { should validate_presence_of(:food).with_message('must exist') }
    it { should validate_presence_of(:recipe).with_message('must exist') }
  end
end
