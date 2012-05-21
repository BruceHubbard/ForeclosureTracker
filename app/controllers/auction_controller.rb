require 'nokogiri'
require 'open-uri'
require './ButlerListingParser'
require './ButlerAuctionParser.rb'

class AuctionController < ApplicationController
  def index
    render :json => @@auctions
  end
  
  def genAuction
    doc = Nokogiri::HTML(open('http://www.butlersheriff.org/geninfo/gen_info_sheriff_sales_listing.htm'))

    listings = ButlerListingParser.new(doc.to_s).listings
    @@auctions = []
    
    for listing in listings do
      puts listing
      url = "http://www.butlersheriff.org/geninfo/" + listing.link
      @@auctions.concat(ButlerAuctionParser.new(Net::HTTP.get(URI.parse(url))).auctions)
    end

    redirect_to :controller=>'home', :action => 'index'
  end
end