class ItemVarPairing < ApplicationRecord
  belongs_to :item_variation
  belongs_to :compat_item, class_name: 'ItemVariation'
end
