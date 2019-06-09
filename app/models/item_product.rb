class ItemProduct < ApplicationRecord
  belongs_to :item
  belongs_to :product, polymorphic: true, dependent: :destroy
  has_many :item_variations
  has_many :sizes, through: :item_variations
end
