require 'nokogiri'
require 'open-uri'
require './ButlerListingParser.rb'
require './ButlerAuctionParser.rb'

doc = Nokogiri::HTML(open('http://www.butlersheriff.org/geninfo/gen_info_sheriff_sales_listing.htm'))

listings = ButlerListingParser.new(doc.to_s).listings

for listing in listings do
  url = "http://www.butlersheriff.org/geninfo/" + listing.link
  auctions = ButlerAuctionParser.new(Net::HTTP.get(URI.parse(url))).auctions
  
  for auction in auctions
    puts auction
  end
end

