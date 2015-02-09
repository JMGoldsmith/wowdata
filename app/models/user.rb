class User < ActiveRecord::Base
  has_many :auction_and_items
end
