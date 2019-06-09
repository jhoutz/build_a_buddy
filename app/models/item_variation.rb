class ItemVariation < ApplicationRecord
  belongs_to :item
  belongs_to :size
  has_many :purchase_order_items
  has_many :item_var_pairings
  has_many :compat_items, through: :item_var_pairings

  def product
    item.product
  end
end
