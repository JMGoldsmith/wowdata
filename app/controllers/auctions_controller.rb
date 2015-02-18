class AuctionsController < ApplicationController
  before_action :authenticate_user!
  LazyHighCharts::HighChart

  
  
  def index
    connection = ActiveRecord::Base.connection.raw_connection
    # need to include params ID in to queries
    params_array = [] 
    params_array.push(params[:item_id])
    #sql queries
    @buyout_data = connection.exec(%q[select date_trunc('day', created_at)::date, avg(buyout) from auctions where item_id = $1 and quantity = 20 group by 1 order by 1;],params_array)
    @hourly_buyout_data = connection.exec(%q[select date_trunc('hour', created_at), avg(buyout) from auctions where item_id = $1 and quantity = 20 group by 1 order by 1;],params_array)
    @bid_data = connection.exec(%q[select date_trunc('day', created_at), avg(bid) from auctions where item_id = $1 and quantity = 20 group by 1 order by 1;],params_array)
    @hourly_bid_data = connection.exec(%q[select date_trunc('day', created_at), avg(bid) from auctions where item_id = $1 and quantity = 20 group by 1 order by 1;],params_array)
    @seller_data = connection.exec(%q[select count(id), owner from auctions where item_id = $1 group by owner order by count desc limit 5;],params_array)
    @total_auctions = connection.exec(%q[select date_trunc('day', created_at), sum(quantity) from auctions where item_id = $1 and quantity = 20 group by 1 order by 1;],params_array)
    #arrays to be flattened
    range_array = []
    total_array = []
    buyout_array = []
    bid_array = []
    seller_name_array = []
    seller_total_array = []
    hourly_bid_array = []
    hourly_buyout_array = []
    #begin looping to flatten
    @buyout_data.entries.each do |x|
      avg_buyout_array = []
      avg_buyout_array.push(x['date_trunc'])
      avg_buyout_array.push((x['avg'].to_i/10000).floor.abs)
      buyout_array.push(avg_buyout_array)
      range_array.push(x['date_trunc'])
    end
    @bid_data.entries.each do |x|
      avg_bid_array = []
      avg_bid_array.push(x['date_trunc'])
      avg_bid_array.push((x['avg'].to_i/10000).floor.abs)
      bid_array.push(avg_bid_array)
    end
    @seller_data.entries.each do |x|
      seller_total_array.push(x['count'].to_i)
      seller_name_array.push(x['owner'])
    end
    @hourly_buyout_data.entries.each do |x|
      avg_buyout_array = []
      avg_buyout_array.push(x['date_trunc'])
      avg_buyout_array.push((x['avg'].to_i/10000).floor.abs)
      hourly_buyout_array.push(avg_buyout_array)
    end
    @hourly_bid_data.entries.each do |x|
      avg_buyout_array = []
      avg_buyout_array.push(x['date_trunc'])
      avg_buyout_array.push((x['avg'].to_i/10000).floor.abs)
      hourly_bid_array.push(avg_buyout_array)
    end
    @total_auctions.entries.each do |x|
      total_auction_array = []
      total_auction_array.push(x['date_trunc'])
      total_auction_array.push(x['sum'].to_i)
      total_array.push(total_auction_array)
    end
    @auction_item = Item.find_by(item_id: params[:item_id])
    #graphs
    @avg_chart = LazyHighCharts::HighChart.new('graph') do |f|
        f.title(:text => "#{@auction_item[:name]} average last 10 days by stacks of 20" )
        f.options[:xAxis][:categories] = range_array
        f.series(:name => "Buyout", :yAxis => 0, :data => buyout_array)
        f.series(:name => "Bid", :yAxis => 0, :data => bid_array)
        f.yAxis [
          {:title => {:text => "Cost in gold", :margin => 10} },
        ]
        f.legend(:align => 'right', :verticalAlign => 'top', :y => 75, :x => -50, :layout => 'vertical',)
        f.chart({:defaultSeriesType=>"line"})
    end
    @hourly_chart = LazyHighCharts::HighChart.new('graph') do |f|
        f.title(:text => "#{@auction_item[:name]} average 24 hours by stacks of 20" )
        f.options[:xAxis][:categories] = range_array
        f.series(:name => "Buyout", :yAxis => 0, :data => buyout_array)
        f.series(:name => "Bid", :yAxis => 0, :data => bid_array)
        f.yAxis [
          {:title => {:text => "Cost in gold", :margin => 10} },
        ]
        # f.legend(:align => 'right', :verticalAlign => 'top', :y => 75, :x => -50, :layout => 'vertical',)
        f.chart({:defaultSeriesType=>"line"})
    end
    @seller_chart = LazyHighCharts::HighChart.new('graph') do |f|       
           f.series(:name=>'Sellers', :data=> seller_total_array)
           f.title({ :text=>"Most active sellers for #{@auction_item[:name]}"})
           # f.legend({:align => 'right', 
           #          :x => -100, 
           #          :verticalAlign=>'top',
           #          :y=>20,
           #          :floating=>"true",
           #          :backgroundColor=>'#FFFFFF',
           #          :borderColor=>'#CCC',
           #          :borderWidth=>1,
           #          :shadow=>"false"
           #          })
           f.options[:chart][:defaultSeriesType] = "column"
           f.options[:xAxis] = {:plot_bands => "none", :title=>{:text=>"Name"}, :categories => seller_name_array}
           f.options[:yAxis][:title] = {:text=>"Total auctions"}
    end
    @total_chart = LazyHighCharts::HighChart.new('graph') do |f|
        f.title(:text => "#{@auction_item[:name]} total for sale by day" )
        f.options[:xAxis][:categories] = range_array
        f.series(:name => "Total", :yAxis => 0, :data => total_array)
        f.yAxis [
          {:title => {:text => "Total number", :margin => 0} },
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
