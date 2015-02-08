class ItemData < ActiveRecord::Migration
  def change
    create_table :item do |t|
      t.integer :buyPrice
      t.boolean :equippable
      t.integer :item_id
      t.string :name
      t.integer :stackable
      t.integer :sellPrice
    end
  end
end
