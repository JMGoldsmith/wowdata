class CreateUserAuctions < ActiveRecord::Migration
  def change
    create_table :user_auctions do |t|
       t.integer :user_id
      t.integer :auction
      t.string :owner
      t.integer :item_id
      t.timestamps null: false
    end
  end
end
