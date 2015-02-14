class AuctionAndItem < ActiveRecord::Base
  belongs_to :auctions
  belongs_to :items

 
end
