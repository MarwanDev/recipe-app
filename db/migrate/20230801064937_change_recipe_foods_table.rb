class ChangeRecipeFoodsTable < ActiveRecord::Migration[7.0]
  def change
    remove_reference :recipe_foods, :user, null: false, foreign_key: { to_table: :users }
    add_reference :recipe_foods, :food, null: false, foreign_key: { to_table: :foods }
  end
end
