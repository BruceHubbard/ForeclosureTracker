require 'nokogiri'
require 'open-uri'
require './ButlerCountyAuctions'

class AuctionController < ApplicationController
  def index
    render :json => Auction.all
  end
  
  def genAuction
    ButlerCountyAuctions.new.auctions.each do |auction|
      if(!Auction.exists?(:address => auction.address))
        auction.save
      end
    end

    redirect_to :controller=>'home', :action => 'index'
  end
end