class AuctionData < ActiveRecord::Migration
  def change
    create_table :auction do |t|
        t.integer :auc
        t.integer :item_id
        t.string :owner
        t.string :ownerRealm
        t.integer :bid
        t.integer :buyout
        t.integer :quantity
        t.string :timeLeft
        t.integer :rand
        t.integer :seed
        t.integer :context
        
        t.timestamps null:false
    end
  end
end
