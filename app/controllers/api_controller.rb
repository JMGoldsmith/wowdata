class ApiController < ApplicationController
  # before_action :authenticate_user!


  def buyout_data
    connection = ActiveRecord::Base.connection.raw_connection
    params_array = []
    params_array.push(params[:id])
    @buyout_data_api = connection.exec(%q[select date_trunc('day', created_at)::date, avg(buyout) from auctions where item_id = $1 and quantity = 20 group by 1 order by 1;],params_array)
    render json: @buyout_data_api, status: 200
  end

  def hourly_buyout_data
    connection = ActiveRecord::Base.connection.raw_connection
    params_array = []
    params_array.push(params[:id])
    @hourly_buyout_data_api = connection.exec(%q[select date_trunc('hour', created_at), avg(buyout) from auctions where item_id = $1 and created_at >= current_date and quantity = 20 group by 1 order by 1;],params_array)
    render json: @hourly_buyout_data_api, status: 200
  end

  def bid_data
    connection = ActiveRecord::Base.connection.raw_connection
    params_array = []
    params_array.push(params[:id])
    @bid_data_api = connection.exec(%q[select date_trunc('day', created_at), avg(bid) from auctions where item_id = $1 and quantity = 20 group by 1 order by 1;],params_array)
    render json: @bid_data_api, status: 200
  end

  def hourly_bid_data
    connection = ActiveRecord::Base.connection.raw_connection
    params_array = []
    params_array.push(params[:id])
    @hourly_bid_data_api = connection.exec(%q[select date_trunc('hour', created_at), avg(bid) from auctions where item_id = $1 and created_at >= current_date and quantity = 20 group by 1 order by 1;],params_array)
    render json: @hourly_bid_data_api, status: 200
  end

  def seller_data
    connection = ActiveRecord::Base.connection.raw_connection
    params_array = []
    params_array.push(params[:id])
    @seller_data_api = connection.exec(%q[select count(id), owner from auctions where item_id = $1 group by owner order by count desc limit 10;],params_array)
    render json: @seller_data_api, status: 200
  end

  def total_auctions
    connection = ActiveRecord::Base.connection.raw_connection
    params_array = []
    params_array.push(params[:id])
    @total_auctions_api = connection.exec(%q[select date_trunc('day', created_at), sum(quantity) from auctions where item_id = $1 and quantity = 20 group by 1 order by 1;],params_array)
    render json: @total_auctions_api, status: 200
  end
  private
  def params_id
    params.permit(:id,:auc,:item_id,:owner,:ownerRealm,:bid,:buyout,:quantity,:timeLeft,:rand,:seed,:situation,:name)
  end
end
