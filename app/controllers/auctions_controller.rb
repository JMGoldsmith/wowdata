class AuctionsController < ApplicationController
  before_action :authenticate_user!
  LazyHighCharts::HighChart

  
  
  def index
    connection = ActiveRecord::Base.connection.raw_connection
    # need to include params ID in to queries
    params_array = [] 
    params_array.push(params[:item_id])
    @buyout_data = connection.exec(%q[select date_trunc('day', created_at), avg(buyout) from auctions where item_id = $1 and quantity = 20 group by 1 order by 1;],params_array)
    @bid_data = connection.exec(%q[select date_trunc('day', created_at), avg(bid) from auctions where item_id = $1 and quantity = 20 group by 1 order by 1;],params_array)
    buyout_array = []
    bid_array = []
    @buyout_data.entries.each do |x|
      avg_buyout_array = []
      avg_buyout_array.push(x['date_trunc'])
      avg_buyout_array.push((x['avg'].to_i/10000).floor.abs)
      buyout_array.push(avg_buyout_array)
    end
    @bid_data.entries.each do |x|
      avg_bid_array = []
      avg_bid_array.push(x['date_trunc'])
      avg_bid_array.push((x['avg'].to_i/10000).floor.abs)
      bid_array.push(avg_bid_array)
    end
    @auction_item = Item.find_by(item_id: params[:item_id])
    @chart = LazyHighCharts::HighChart.new('graph') do |f|
        f.title(:text => @auction_item[:name])
        f.options[:xAxis][:categories] = {pointInterval: 1.day*1000, pointStart: 7.days.ago.getutc.to_i*1000}
        # f.xAxis(:pointInterval => 1.day, :data => buyout_array)
        # f.xAxis [
        #   {:title => {:text => "Time", :margin => 10} },
        # ]

        f.series(:name => "Buyout", :yAxis => 0, :data => buyout_array)
        f.series(:name => "Bid", :yAxis => 0, :data => bid_array)
        
        
        f.yAxis [
          {:title => {:text => "Cost in gold", :margin => 10} },
        ]

        f.legend(:align => 'right', :verticalAlign => 'top', :y => 75, :x => -50, :layout => 'vertical',)
        f.chart({:defaultSeriesType=>"line"})
    end
  end

  private
  def params_id
    params.permit(:id,:auc,:item_id,:owner,:ownerRealm,:bid,:buyout,:quantity,:timeLeft,:rand,:seed,:situation,:name)
  end 
end
