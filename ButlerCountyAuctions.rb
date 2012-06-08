require 'nokogiri'
require 'open-uri'
require './ButlerListingParser.rb'
require './ButlerAuctionParser.rb'

class ButlerCountyAuctions
  @@urlBase = 'http://www.butlersheriff.org/geninfo/'
  @@listingUrl = @@urlBase + 'gen_info_sheriff_sales_listing.htm'
  
  def auctions
    doc = Nokogiri::HTML(open(@@listingUrl))

    listings = ButlerListingParser.new(doc.to_s).listings
    all_auctions = []
    
    for listing in listings do
      url = @@urlBase + listing.link
      all_auctions.concat(ButlerAuctionParser.new(Net::HTTP.get(URI.parse(url))).auctions)
    end
    
    all_auctions
  end
end
