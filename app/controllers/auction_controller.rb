require 'nokogiri'
require 'open-uri'
require './ButlerCountyAuctions.rb'
require './AddressCleanser.rb'

class AuctionController < ApplicationController
  def index
    render :json => Auction.search(params)
  end
  
  def fix
    @toFix = Auction.where(:hasValidAddress => false).all
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