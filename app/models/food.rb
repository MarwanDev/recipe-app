class Food < ApplicationRecord
  belongs_to :user, class_name: 'User'
  has_many :recipe_foods, foreign_key: 'food_id'
  has_many :recipes, through: :recipe_foods, dependent: :destroy

  validates :user, presence: true
end
