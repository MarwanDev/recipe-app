class Recipe < ApplicationRecord
  belongs_to :user, class_name: 'User'
  has_many :recipe_food, foreign_key: 'recipe_id'
  has_many :foods, through: :recipe_foods, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true
end
