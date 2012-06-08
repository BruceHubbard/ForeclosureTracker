require 'rspec'
require './AddressCleanser.rb'

describe AddressCleanser do
  
  auction = nil
  
  before(:each) do
    auction = Auction.new
  end
  
  it "Returns address correctly" do
    auction.rawAddress = "2033 MaciNtosH Middletown 45044"

    auction.hasValidAddress.should == false

    AddressCleanser.Cleanse(auction)
    
    auction.hasValidAddress.should == true
    auction.streetNumber.should == "2033"
    auction.streetName.should == "MacIntosh Ln"
    auction.city.should == "Middletown"
    auction.state.should == "OH"
    auction.zip.should == "45044"
    
    auction.latitude.should == 39.4502280
    auction.longitude.should == -84.4299510    
  end  
  
  it "Handles junk properly" do
    auction.rawAddress = "123 Fake St. Middletown, OH 45044"
    
    auction.hasValidAddress.should == false
    
    AddressCleanser.Cleanse(auction)
    
    auction.hasValidAddress.should == false
  end
end