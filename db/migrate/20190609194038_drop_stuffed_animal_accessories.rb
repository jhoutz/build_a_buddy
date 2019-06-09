class DropStuffedAnimalAccessories < ActiveRecord::Migration[5.2]
  def change
    drop_table :stuffed_animal_accessories do |t|
      t.references :stuffed_animal, foreign_key: true
      t.references :accessory, foreign_key: true

      t.timestamps
    end
  end
end
