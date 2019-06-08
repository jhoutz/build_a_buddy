class Item < ApplicationRecord
  has_one :item_product, dependent: :destroy
  has_one :stuffed_animal, through: :item_product, source: :product, source_type: 'StuffedAnimal'
  has_one :accessory, through: :item_product, source: :product, source_type: 'Accessory'
  has_many :item_sizes
  has_many :sizes, through: :item_sizes
  accepts_nested_attributes_for :item_product, allow_destroy: true

  def self.kinds
    [StuffedAnimal, Accessory]
  end

  def product
    item_product&.product
  end

  def product_name
    product&.class&.name&.downcase
  end
end
