class CreateUserProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :user_products do |t|
      t.integer :user_id
      t.integer :product_id
      t.boolean :removed_from_cart

      t.timestamps
    end
  end
end
