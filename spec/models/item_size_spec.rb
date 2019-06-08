require 'rails_helper'

RSpec.describe ItemSize, type: :model do
  it { should belong_to(:item) }
  it { should belong_to(:size) }
  it { should have_many(:purchase_order_items) }
end
