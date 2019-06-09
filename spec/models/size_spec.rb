require 'rails_helper'

RSpec.describe Size, type: :model do
  it { should have_many(:item_variations) }
  it { should have_many(:items).through(:item_variations) }
end
