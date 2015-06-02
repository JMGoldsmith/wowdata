# WoWData - The World of Warcraft auction data viewer

## Built with:

#### Framework
- Rails
- Bootstrap

#### Gems
- lazy_high_charts - charting gem
- pg - database connection gem
- httparty - rest client gem
- devise - user sessions
- bootstrap-sass - front end
- rspec - testing

#### APIs
- WoWhead
- api.blizzard.com

## How it works

##### Backend

- Rake task calls method in the Auctions model.
- This method then pulls an original request from the Blizzard API.
- This request returns a second link holding the requested data in JSON.
- The method then grabs that JSON and pushes it in to the Postgres database.
- Before pushing, it filters the data based on 7 items.
- This process occurs once every hour based upon a rake task in schedule.rb.

##### API endpoints
/api/:id/buyout_data(.:format)         api#buyout_data
/api/:id/hourly_buyout_data(.:format)  api#hourly_buyout_data
/api/:id/bid_data(.:format)            api#bid_data
/api/:id/hourly_bid_data(.:format)     api#hourly_bid_data
/api/:id/seller_data(.:format)         api#seller_data
/api/:id/total_auctions(.:format)      api#total_auctions

##### Front End

- WoWhead API returns graphical inofrmation based upon item IDs.
- This allows hover over actions.
- From the items page, you can click on items auction page to get the current data for that auction.
- There are 4 graphs, showing average over time, past 24 hours, total items sold, and the top sellers.
- Trades allow you to post requests for large amounts of a certain item that may not be available on the auction house or for a price that is lower than the auction house.

##### ERD
![My Image](https://raw.githubusercontent.com/JMGoldsmith/wowdata/master/planning/ERD.jpg)
