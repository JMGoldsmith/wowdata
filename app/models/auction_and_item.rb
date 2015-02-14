class AuctionAndItem < ActiveRecord::Base
  belongs_to :auctions
  belongs_to :items

  def self.cost_over_time(date)
    where("date(created_at) = ?",date).average('buyout')
  end
end
