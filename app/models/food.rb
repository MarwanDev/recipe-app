class Food < ApplicationRecord
  belongs_to :user, class_name: 'User'
  has_many :recipe_food, foreign_key: 'food_id'
end
