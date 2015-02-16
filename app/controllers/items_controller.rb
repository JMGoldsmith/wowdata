class ItemsController < ApplicationController
  before_action :authenticate_user!
  def index
    @item_data = Item.all
    @auction_data = Auction.all
  end
end
