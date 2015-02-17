desc "This task is called by the Heroku scheduler add-on"
task :update_database => :environment do
  puts "Loading data in to DB"
  Auction.data_dump
  puts "done."
end

task :send_reminders => :environment do
  User.send_reminders
end