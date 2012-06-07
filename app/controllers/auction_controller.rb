require 'nokogiri'
require 'open-uri'
require './ButlerCountyAuctions'
require './AddressCleanser'

class AuctionController < ApplicationController
  def index
    render :json => Auction.search(params)
  end
  
  def genAuction
    ButlerCountyAuctions.new.auctions.each do |auction|
      if(!Auction.exists?(:rawAddress => auction.rawAddress))
        puts auction.rawAddress
        AddressCleanser.Cleanse(auction)
        auction.save
      end
    end

    redirect_to :controller=>'home', :action => 'index'
  end
end