require 'rails_helper'

RSpec.describe Size, type: :model do
  it { should have_many(:item_sizes) }
  it { should have_many(:items).through(:item_sizes) }
end
