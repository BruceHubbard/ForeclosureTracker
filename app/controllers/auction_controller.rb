require 'nokogiri'
require 'open-uri'
require './ButlerCountyAuctions.rb'
require './AddressCleanser.rb'

class AuctionController < ApplicationController
  def index
    render :json => Auction.search(params)
  end
  
  def fix
    @toFix = Auction.InvalidAddresses
  end

  def rerunGeocode
    @toFix = Auction.InvalidAddresses
    
    for a in @toFix
      AddressCleanser.Cleanse(a)
      
      if(a.hasValidAddress) then a.save end
    end
    
    redirect_to :controller=>'auction', :action => 'fix'
  end
  
  def genAuction
    ButlerCountyAuctions.new.auctions.each do |auction|
      if(!Auction.exists?(:rawAddress => auction.rawAddress))
        AddressCleanser.Cleanse(auction)
        auction.save
      end
    end

    redirect_to :controller=>'home', :action => 'index'
  end
end