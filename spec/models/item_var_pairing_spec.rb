require 'rails_helper'

RSpec.describe ItemVarPairing, type: :model do
  it { should belong_to(:item_variation) }
  it { should belong_to(:compat_item) }
end
