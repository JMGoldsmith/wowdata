class UserAuction < ActiveRecord::Base
  has_many :users
  has_many :auctions
end