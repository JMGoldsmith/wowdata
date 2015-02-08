class CreateAuctionAndItems < ActiveRecord::Migration
  def change
    create_table :auction_and_items do |t|
      t.integer :auc_item_id
      t.integer :item_id
      t.timestamps null: false
    end
  end
end
