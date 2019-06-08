class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items, &:timestamps
  end
end
