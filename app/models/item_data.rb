class ItemData < ActiveRecord::Base
  belongs_to :auctions
  has_many :auction_and_items
end
