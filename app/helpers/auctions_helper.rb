module AuctionsHelper
  def money_convert
    gold = (buyout/10000).floor.abs 
    silver = ((buyout/100) % 100).floor.abs
    copper = (buyout % 100).floor.abs
    puts "#{gold}g#{silver}s#{copper}c"
  end
  def delete_old_data
  	Auctions.where('created_at < ?', 7.days.ago).each do |auction|
  		auction.destroy
    end
  end
end
