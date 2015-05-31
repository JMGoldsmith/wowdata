class CreateAuctionData < ActiveRecord::Migration
  def change
    create_table :auction_data do |t|
      #edited due to bug in rails 4.2.0
        t.integer :auc, limit: 8
        t.integer :item_id, limit: 8
        t.string :owner
        t.string :ownerRealm
        t.integer :bid, limit: 8
        t.integer :buyout, limit: 8
        t.integer :quantity
        t.string :timeLeft
        t.integer :rand, limit: 8
        t.integer :seed, limit: 8
        t.integer :context, limit: 8


      t.timestamps null: false
    end
  end
end
