class CreateTrades < ActiveRecord::Migration
  def change
    create_table :trades do |t|
       t.string :realm
       t.string :item
       t.integer :number_of_items
       t.integer :number_of_stacks
       t.integer :price_per_stack
       t.integer :price_per_item
       t.string :bnet_id
       t.boolean :cod
       t.boolean :order_filled
      t.timestamps null: false
    end
  end
end
