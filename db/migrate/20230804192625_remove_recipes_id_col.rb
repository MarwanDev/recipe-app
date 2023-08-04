class RemoveRecipesIdCol < ActiveRecord::Migration[7.0]
  def change
    remove_column :recipe_foods, :recipes_id
  end
end
