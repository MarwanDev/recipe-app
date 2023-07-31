require 'rails_helper'

RSpec.describe "recipe_foods/edit", type: :view do
  let(:recipe_food) {
    RecipeFood.create!(
      quantity: "9.99",
      user: nil,
      recipe: nil
    )
  }

  before(:each) do
    assign(:recipe_food, recipe_food)
  end

  it "renders the edit recipe_food form" do
    render

    assert_select "form[action=?][method=?]", recipe_food_path(recipe_food), "post" do

      assert_select "input[name=?]", "recipe_food[quantity]"

      assert_select "input[name=?]", "recipe_food[user_id]"

      assert_select "input[name=?]", "recipe_food[recipe_id]"
    end
  end
end
