class ItemSize < ApplicationRecord
  belongs_to :item
  belongs_to :size
  has_many :purchase_order_items

  def product
    item.product
  end
end
