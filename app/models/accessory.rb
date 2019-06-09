class Accessory < ApplicationRecord
  has_one :item_product, as: :product
  has_one :item, through: :item_product
  has_many :item_variations, through: :item

  validates :description, presence: true
end
