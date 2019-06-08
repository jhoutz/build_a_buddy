class CreateItemProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :item_products do |t|
      t.integer :item_id, unique: true, null: false
      t.references :product, polymorphic: true

      t.timestamps
    end
    add_index :item_products, :item_id
  end
end
