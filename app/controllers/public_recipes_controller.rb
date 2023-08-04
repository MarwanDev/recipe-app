class PublicRecipesController < ApplicationController
  def index
    @public_recipes = Recipe.includes(:user).where(public: true).order(created_at: :desc)

    @total_prices = {}
    @public_recipes.each do |recipe|
      total_price = recipe.recipe_foods.sum { |rf| rf.food.price * rf.quantity }
      @total_prices[recipe.id] = total_price
    end
  end
end
