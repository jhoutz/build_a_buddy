class ItemVariation < ApplicationRecord
  belongs_to :item
  belongs_to :size
  has_many :purchase_order_items
  has_many :compatible_products, class_name: 'ItemVariationPairing'
  has_many :item_variation_pairings, through: :compatible_products, source: :item_variation_pairing

  def product
    item.product
  end
end
