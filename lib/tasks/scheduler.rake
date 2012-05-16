require './ButlerCountyAuctions'

desc "This task is called by the Heroku scheduler add-on"
task :update_feed => :environment do
    puts "Pulling auctions"
    
    puts ButlerCountyAuctions.new.auctions[0]
    
    puts "done."
end
