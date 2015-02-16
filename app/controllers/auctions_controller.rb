class AuctionsController < ApplicationController
  before_action :authenticate_user!
  LazyHighCharts::HighChart
  
  def index
    @auction_data = Auction.where("item_id = ?", params[:id]).order(:created_at)
    @categories = @auction_data.map { |x| x.created_at }
    @buyout = @auction_data.map(&:buyout)
    @bid = @auction_data.map(&:bid)
    @auction_item = Item.find_by(item_id: params[:item_id])
    @chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(:text=> @auction_item[:name] )
      f.options[:xAxis][:categories] = @categories
      f.labels(:items=>[:html=>"Total Auction Info", :style=>{:left=>"40px", :top=>"8px", :color=>"black"} ])      
      f.series(:type=> 'spline',:name=> 'Buyout',:data=> @buyout)
      f.series(:type=> 'spline',:name=> 'Bid',:data=> @bid)
      f.series(:type=> 'spline',:name=> 'Average', :data=> @average)
    end
  end
  private
  def params_id
    params.permit(:id,:auc,:item_id,:owner,:ownerRealm,:bid,:buyout,:quantity,:timeLeft,:rand,:seed,:situation,:name)
  end 
end
