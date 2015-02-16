class AuctionsController < ApplicationController
  before_action :authenticate_user!
  LazyHighCharts::HighChart

  
  
  def index

    @auction_data = Auction.where("item_id = ?", params[:item_id]).where("quantity = 20").order(:created_at).group(:created_at, :id)
    buyout_array = []
    bid_array = []
    average_array = []
    @bid = @auction_data.map(&:bid)
    @bid_average = @bid.sum / @bid.size
    @buyout = @auction_data.map(&:buyout)
    @buyout_average = @buyout.sum/@buyout.size
    @average_of_both = (@buyout_average+@bid_average)/2
    # @auction_data.map do |x|
    #   new_buyout_array = []
    #   new_array = []
    #   x.created_at
    #   average_bid = x.bid.sum/x.bid.size
    #   average_buyout = x.buyout.sum/x.buyout.size
    #   new_array.push(x.created_at)
    #   new_array.push(average)
    #   bid_array << new_array
    # end
    # @category = @auction_data.map { |x| x.created_at}
    # @buyout = @auction_data.map do |x|
    #   x.buyout 
    #   gold = (x.buyout/10000).floor.abs 
    #   silver = ((x.buyout/100) % 100).floor.abs
    #   copper = (x.buyout % 100).floor.abs
    #   "#{gold}g#{silver}s#{copper}c"
    # end
    
     @auction_item = Item.find_by(item_id: params[:item_id])
     @chart = LazyHighCharts::HighChart.new('graph') do |f|
          f.title(:text => @auction_item[:name])
          f.xAxis(
            type: 'datetime'
           )

          f.series(:name => "Buyout", :yAxis => 0, :data => @buyout)
          f.series(:name => "Bid", :yAxis => 0, :data => @bid)
          f.series(:name => "Average", :yAxis => 0, :data => @average)
          
          f.yAxis [
            {:title => {:text => "Revenue", :margin => 70} },
            {:title => {:text => "Revenue"}, :opposite => true},
          ]

          f.legend(:align => 'right', :verticalAlign => 'top', :y => 75, :x => -50, :layout => 'vertical',)
          f.chart({:defaultSeriesType=>"line"})
        end
    # @chart = LazyHighCharts::HighChart.new('graph') do |f|
    #   f.title(:text=> @auction_item[:name] )
    #   f.options[:xAxis][:categories] = @category
    #   f.labels(:items=>[:html=>"Total Auction Info", :style=>{:left=>"40px", :top=>"8px", :color=>"black"} ])      
    #   f.series(:type=> 'spline',:name=> 'Buyout',:data=> @buyout)
    #   f.series(:type=> 'spline',:name=> 'Bid',:data=> @bid)
    #   f.series(:type=> 'spline',:name=> 'Average', :data=> @average)
    # end
  end
  private
  def params_id
    params.permit(:id,:auc,:item_id,:owner,:ownerRealm,:bid,:buyout,:quantity,:timeLeft,:rand,:seed,:situation,:name)
  end 
end
