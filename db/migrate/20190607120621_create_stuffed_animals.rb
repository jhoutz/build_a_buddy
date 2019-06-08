class CreateStuffedAnimals < ActiveRecord::Migration[5.2]
  def change
    create_table :stuffed_animals do |t|
      t.text :description

      t.timestamps
    end
  end
end
