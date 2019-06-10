class PurchaseOrder < ApplicationRecord
  has_many :purchase_order_items

  before_destroy :delete_purchase_order_items

  private

  # Replaces dependent: :destroy due to foreign_key constraint
  # issue on PurchaseOrderItem
  def delete_purchase_order_items
    purchase_order_items.destroy_all
  end
end
