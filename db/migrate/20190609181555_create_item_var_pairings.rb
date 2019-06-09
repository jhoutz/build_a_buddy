class CreateItemVarPairings < ActiveRecord::Migration[5.2]
  def change
    create_table :item_var_pairings do |t|
      t.references :item_variation, index: true, foreign_key: true
      t.references :compat_item, index: true

      t.timestamps null: false
    end

    # NOTE: Shortened names were used (item_var_pairings, compat_item) since
    # max index length for pSQL is 63 characters
    add_foreign_key :item_var_pairings, :item_variations, column: :compat_item_id
    add_index :item_var_pairings, %i[item_variation_id compat_item_id], unique: true
  end
end
