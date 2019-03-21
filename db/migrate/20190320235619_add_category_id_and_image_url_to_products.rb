class AddCategoryIdAndImageUrlToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :category_id, :integer
    add_column :products, :image_url, :string
  end
end
