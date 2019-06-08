require 'rails_helper'

RSpec.describe PurchaseOrder, type: :model do
  it { should have_many(:purchase_order_items) }
end
