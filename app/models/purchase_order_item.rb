class PurchaseOrderItem < ApplicationRecord
  belongs_to :purchase_order
  belongs_to :item_size
end
