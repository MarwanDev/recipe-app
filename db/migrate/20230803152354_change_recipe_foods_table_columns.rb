class ChangeRecipeFoodsTableColumns < ActiveRecord::Migration[7.0]
  def change
    remove_reference :recipe_foods, :recipe, foreign_key: { to_table: :foods }
    add_reference :recipe_foods, :recipes, foreign_key: { to_table: :recipes }
  end
end
