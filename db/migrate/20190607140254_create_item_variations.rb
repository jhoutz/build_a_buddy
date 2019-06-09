class CreateItemVariations < ActiveRecord::Migration[5.2]
  def change
    create_table :item_variations do |t|
      t.references :item, foreign_key: true
      t.references :item_product, foreign_key: true
      t.references :size, foreign_key: true
      t.integer :quantity
      t.float :cost
      t.float :sale_price

      t.timestamps
    end
  end
end
