class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :price
      t.integer :bland
      t.integer :category
      t.text :image_url
      t.text :product_url

      t.timestamps
    end
  end
end
