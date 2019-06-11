module Recommendation
  def recommend_items # recommend movies to a purchase_order
    # self = ItemVariation instance
    po_items = purchase_order_items
    # If no purchase orders exist for item variation, just return the first 5
    # item variations that are not the current item variation
    return ItemVariation.where.not(self).limit(5) if po_items.blank?

    # Grab the purchase orders that contain this item variation
    pos_with_items = PurchaseOrder.joins(:purchase_order_items).where(purchase_order_items: po_items).uniq
    # Create a new hash with a default value of 0
    other_items_hash = Hash.new(0)
    # Loop through purchase orders containing item variation
    pos_with_items.each do |pos|
      # Retrieve item variations from the purchase order that is not the current item variation
      other_item_vars = pos.purchase_order_items.where.not(item_variation: self).map(&:item_variation)
      # Of these item variations,
      other_item_vars.each do |oiv|
        # Add ID of other item variation and iterate the value (count) by 1
        other_items_hash[oiv.id] += 1
      end
    end

    # Order hash by keys (count)
    sorted_other_items_hash = other_items_hash.sort_by { |_id, count| count }.reverse.to_h
    # ItemVariation query is automatically ordered by the keys order
    ItemVariation.where(id: sorted_other_items_hash.keys).limit(5)
  end
end
