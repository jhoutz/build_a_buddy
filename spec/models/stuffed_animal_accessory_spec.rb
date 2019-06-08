require 'rails_helper'

RSpec.describe StuffedAnimalAccessory, type: :model do
  it { should belong_to(:stuffed_animal) }
  it { should belong_to(:accessory) }
end
