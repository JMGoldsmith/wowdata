class ItemData < ActiveRecord::Base
  # before_action :authenticate_user!
  belongs_to :auctions
  has_many :auction_and_items

  def self.get_item_id_and_name(id)
    url = ("http://us.battle.net/api/wow/item/#{id}")
    response = HTTParty.get(url)
    id = response['id']
    name = response['name']
    sell_price = response['sellPrice']
    stacks = response['stackable']
    buy_price = response['buyPrice']
    ItemData.create({item_id: id, name: name, sellPrice: sell_price, stackable: stacks, buyPrice: buy_price })
  end
end
