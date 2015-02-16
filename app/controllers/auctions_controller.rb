class AuctionsController < ApplicationController
  before_action :authenticate_user!
  LazyHighCharts::HighChart

  
  
  def index
    connection = ActiveRecord::Base.connection.raw_connection
    @buyout_data = connection.exec %q[select date_trunc('hour', created_at), avg(buyout) from auctions group by 1 order by 1;]
    @bid_data = connection.exec %q[select date_trunc('hour', created_at), avg(buyout) from auctions group by 1 order by 1;]
    buyout_array = []
    bid_array = []
    @buyout_data.entries.each do |x|
      avg_buyout_array = []
      avg_buyout_array.push(x['date_trunc'])
      avg_buyout_array.push(x['avg'].to_i)
      buyout_array.push(avg_buyout_array)
    end
    @bid_data.entries.each do |x|
      avg_bid_array = []
      avg_bid_array.push(x['date_trunc'])
      avg_bid_array.push(x['avg'].to_i)
      bid_array.push(avg_bid_array)
    end
    
    
     @auction_item = Item.find_by(item_id: params[:item_id])
     @chart = LazyHighCharts::HighChart.new('graph') do |f|
          f.title(:text => @auction_item[:name])
          f.xAxis(
            type: 'datetime'
           )

          f.series(:name => "Buyout", :yAxis => 0, :data => buyout_array)
          f.series(:name => "Bid", :yAxis => 0, :data => bid_array)
          
          
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
