class RecipeFood < ApplicationRecord
  belongs_to :food, class_name: 'Food', foreign_key: 'food_id'
  belongs_to :recipe, class_name: 'Recipe', foreign_key: 'recipe_id'

  validates :food, presence: true
  validates :recipe, presence: true
  validates :quantity, presence: true
end
