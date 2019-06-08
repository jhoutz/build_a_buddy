class Accessory < ApplicationRecord
  has_one :item_product, as: :product
  has_one :item, through: :item_product
  has_many :stuffed_animal_accessories
  has_many :accessories, through: :stuffed_animal_accessories
end
