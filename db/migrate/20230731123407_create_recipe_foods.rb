class CreateRecipeFoods < ActiveRecord::Migration[7.0]
  def change
    create_table :recipe_foods do |t|
      t.decimal :quantity
      t.references :user, null: false, foreign_key: { to_table: :users }
      t.references :recipe, null: false, foreign_key: { to_table: :foods }

      t.timestamps
    end
  end
end
