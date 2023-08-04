class CreateFoods < ActiveRecord::Migration[7.0]
  def change
    create_table :foods do |t|
      t.string :name
      t.string :meaurement_unit
      t.decimal :price
      t.decimal :quantity
      t.references :user, null: false, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
