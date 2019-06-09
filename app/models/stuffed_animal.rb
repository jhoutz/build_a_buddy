class StuffedAnimal < ApplicationRecord
  has_one :item_product, as: :product
  has_one :item, through: :item_product
end
