class ChangeRecipeColumns < ActiveRecord::Migration[7.0]
  def change
    remove_column :recipes, :preparation_time
    remove_column :recipes, :cooking_time
    add_column :recipes, :preparation_time, :string, null: false
    add_column :recipes, :cooking_time, :string, null: false
  end
end
