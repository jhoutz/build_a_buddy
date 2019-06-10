class Size < ApplicationRecord
  has_many :item_variations
  has_many :items, through: :item_variations

  validates :name, uniqueness: true
end
