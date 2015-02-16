class ChangeTableNames < ActiveRecord::Migration
  def change
    rename_table :item_data, :items
    rename_table :auction_data, :auctions
  end
end
