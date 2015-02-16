module AuctionsHelper
  def money_convert
    gold = (buyout/10000).floor.abs 
    silver = ((buyout/100) % 100).floor.abs
    copper = (buyout % 100).floor.abs
    puts "#{gold}g#{silver}s#{copper}c"
  end
end
