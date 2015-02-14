class AuctionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @auction_data = AuctionData.all
  end

end
