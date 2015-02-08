class CreateItemData < ActiveRecord::Migration
  def change
    create_table :item_data do |t|
      t.integer :buyPrice
      t.boolean :equippable
      t.integer :item_id
      t.string :name
      t.integer :stackable
      t.integer :sellPrice
      t.timestamps null: false
    end
  end
end
