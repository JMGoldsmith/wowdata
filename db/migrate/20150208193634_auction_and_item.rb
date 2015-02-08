class AuctionAndItem < ActiveRecord::Migration
  def change
    create_table :auction_and_item do |t|
      t.integer :auc_item_id
      t.integer :item_id
    end
  end
end
