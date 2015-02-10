class ChangeContextToSituation < ActiveRecord::Migration
  def change
    rename_column :auction_data, :context, :situation
  end
end
