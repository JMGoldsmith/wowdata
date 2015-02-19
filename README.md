# WoWData - The World of Warcraft auction data viewer

## Built with:

#### Gems
- lazy_high_charts
- pg
- httparty
- devise
- bootstrap-sass
- rspec

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

##### Front End

- WoWhead API returns graphical inofrmation based upon item IDs.
- This allows hover over actions.
- From the items page, you can click on items auction page to get the current data for that auction.
- There are 4 graphs, showing average over time, past 24 hours, total items sold, and the top sellers.
