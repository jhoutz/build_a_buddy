require 'rails_helper'

RSpec.describe Accessory, type: :model do
  it { should have_one(:item_product) }
  it { should have_one(:item).through(:item_product) }
  it { should have_many(:stuffed_animal_accessories) }
  it { should have_many(:accessories).through(:stuffed_animal_accessories) }
end
