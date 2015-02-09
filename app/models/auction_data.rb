class AuctionData < ActiveRecord::Base
  require 'json'
  has_many :items
  has_many :users

  def self.get_file_from_blizzard
    key = '97e4ukrcwjwzfseyb2u2tc5thz4kwxrz'
    HTTParty.get('http://us.battle.net/api/wow/auction/data/medivh')
  end

  def self.data_pull_from_file
    response = get_file_from_blizzard
    files = response["files"].first
    url = files["url"]
    HTTParty.get(url)#parse is not working, figure out how to open the file...maybe file.read?
  end
end