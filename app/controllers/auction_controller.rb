require 'nokogiri'
require 'open-uri'
require './ButlerListingParser'
require './ButlerAuctionParser.rb'

class AuctionController < ApplicationController
  def index
    doc = Nokogiri::HTML(open('http://www.butlersheriff.org/geninfo/gen_info_sheriff_sales_listing.htm'))

    listings = ButlerListingParser.new(doc.to_s).listings
    all_auctions = []
    
    for listing in listings do
      puts listing
      url = "http://www.butlersheriff.org/geninfo/" + listing.link
      all_auctions.concat(ButlerAuctionParser.new(Net::HTTP.get(URI.parse(url))).auctions)
    end
    
    render :json => all_auctions
    
  end
end