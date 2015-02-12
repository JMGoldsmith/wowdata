class ItemsController < ApplicationController

  def index
    @item_data = ItemData.all
    
  end
end
