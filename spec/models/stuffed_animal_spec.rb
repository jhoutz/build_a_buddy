require 'rails_helper'

RSpec.describe StuffedAnimal, type: :model do
  it { should have_one(:item_product) }
  it { should have_one(:item).through(:item_product) }
end
