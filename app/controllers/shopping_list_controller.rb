class ShoppingListController < ApplicationController
  def show
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = RecipeFood.all
    @food = Food.all
    @total_price = 0
    @recipe_food.each do |f|
      @total_price += f.quantity * f.food.price
    end
  end
end
