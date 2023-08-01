class Recipe < ApplicationRecord
  belongs_to :user, class_name: 'User'
  has_many :recipe_food, foreign_key: 'recipe_id'
end
