class Auction < ActiveRecord::Base
  has_many :items
  has_many :auction_and_items
  scope :group_by_day, -> { group("date_trunc('day', created_at) ") }

  def self.cost_over_time(date) # this needs to change
    where("date(created_at) = ?",date).average('buyout')
  end

  # def self.money_convert
  #   gold = (buyout/10000).floor.abs
  #   silver = ((buyout/100) % 100).floor.abs
  #   copper = (buyout % 100).floor.abs
  #   puts "#{gold}g#{silver}s#{copper}c"
  # end

  def self.get_file_from_blizzard
    key = '97e4ukrcwjwzfseyb2u2tc5thz4kwxrz' # need to figure out how to hide this, or push to private.
    HTTParty.get('http://us.battle.net/api/wow/auction/data/medivh')
  end
  # def self.data_pull_from_file(item_array)
  #   response = get_file_from_blizzard
  #   files = response["files"].first
  #   url = files["url"]
  #   data = HTTParty.get(url)
  #   auction_data = data["auctions"]["auctions"]
  #   item_array.each do |item_id|
  #     buyouts = []
  #     bids = []
  #     auciton_data.map do |auction|
  #       auc = auction["auc"]
  #       item = auction["item"]
  #       owner = auction["owner"]
  #       ownerRealm = auction["ownerRealm"]
  #       bid = auction["bid"]
  #       buyout = auction["buyout"]
  #       quantity = auction["quantity"]
  #       timeLeft = auction["timeLeft"]
  #       rand = auction["rand"]
  #       seed = auction["seed"]
  #       situation = auction["context"]
  #         if quantity = 20
  #           buyouts.push(buyout)
  #           bids.push(bid)
  #         end
  #       end
  #       # need to avg out bids here
  #       avg_buyouts = buyouts.sum / buyouts.size.to_i
  #       avg_bids = bids.sum / bids.size.to_i
  #       Auction.create({
  #         auc: auc,
  #         item_id: item,
  #         owner: owner,
  #         ownerRealm: ownerRealm,
  #         bid: bid,
  #         buyout: buyout,
  #         quantity: quantity,
  #         timeLeft: timeLeft,
  #         rand: rand,
  #         seed: seed,
  #           situation: situation
  #
  #         })
  #       # then push to DB as a single line
  #   end
  # end
  def self.data_pull_from_file
    response = get_file_from_blizzard
    files = response["files"].first
    url = files["url"]
    data = HTTParty.get(url)
    auction_data = data["auctions"]["auctions"]
    auction_data.map do |auction|
      # byebug
        auc = auction["auc"]
        item = auction["item"]
        owner = auction["owner"]
        ownerRealm = auction["ownerRealm"]
        bid = auction["bid"]
        buyout = auction["buyout"]
        quantity = auction["quantity"]
        timeLeft = auction["timeLeft"]
        rand = auction["rand"]
        seed = auction["seed"]
        situation = auction["context"]
      #change this to push to array, or loop and get a count, then push avg to DB.
      if auction["item"] == 109118 || auction["item"] == 72092 || auction["item"] == 109119 || auction["item"] == 2772 || auction["item"] == 23424 || auction["item"] == 109693 || auction["item"] == 113588
        auction = Auction.create(
          {
           auc: auc,
           item_id: item,
           owner: owner,
           ownerRealm: ownerRealm,
           bid: bid,
           buyout: buyout,
           quantity: quantity,
           timeLeft: timeLeft,
           rand: rand,
           seed: seed,
           situation: situation
             })
      end
    end
  end
  def self.data_dump
      Auction.get_file_from_blizzard
      Auction.data_pull_from_file()
  end
end
