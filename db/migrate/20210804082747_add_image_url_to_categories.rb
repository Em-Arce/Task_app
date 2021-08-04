class AddImageUrlToCategories < ActiveRecord::Migration[6.1]
  def change
    add_column :categories, :image_url, :text
  end
end
