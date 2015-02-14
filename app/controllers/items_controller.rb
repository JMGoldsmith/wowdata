class ItemsController < ApplicationController
  before_action :authenticate_user!
  def index
    @item_data = ItemData.all
    @auction_data = AuctionData.all
  end
end
