require 'rails_helper'

RSpec.describe ItemProduct, type: :model do
  it { should belong_to(:item) }
  it { should belong_to(:product).dependent(:destroy) }
  it { should have_many(:item_variations) }
  it { should have_many(:sizes).through(:item_variations) }
end
