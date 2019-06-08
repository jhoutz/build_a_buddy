require 'rails_helper'

RSpec.describe PurchaseOrderItem, type: :model do
  it { should belong_to(:purchase_order) }
  it { should belong_to(:item_size) }
end
