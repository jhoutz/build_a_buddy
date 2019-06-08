class CreatePurchaseOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :purchase_order_items do |t|
      t.references :purchase_order, foreign_key: true
      t.references :item_size, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
