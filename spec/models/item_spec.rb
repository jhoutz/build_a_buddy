require 'rails_helper'

RSpec.describe Item, type: :model do
  it { should have_one(:item_product).dependent(:destroy) }
  it { should have_one(:stuffed_animal).through(:item_product) }
  it { should have_one(:accessory).through(:item_product) }
  it { should have_many(:item_sizes) }
  it { should have_many(:sizes).through(:item_sizes) }
end
