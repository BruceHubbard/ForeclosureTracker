require 'rspec'
require './ButlerListingParser.rb'

describe ButlerListingParser do
  before(:each) do
    @mockInput = File.open("./spec/listing.html", "rb").read
    @parser = ButlerListingParser.new(@mockInput)
    @listings = @parser.listings
  end
  
  it "Returns 14 listings" do
    @listings.length.should == 14
  end
  
  it "returns listing objects" do
    for l in @listings 
      l.should be_a(Listing)
      l.link.should_not be_nil
      l.date.should_not be_nil
    end
  end
  
  it "returns expected values" do
    @listings[0].should == Listing.new("sales/sales071212.htm", "July 12, 2012")
    @listings[1].should == Listing.new("sales/sales062812.htm", "June 28, 2012")
    @listings[2].should == Listing.new("sales/sales062112.htm", "June 21, 2012")
    @listings[3].should == Listing.new("sales/sales061412.htm", "June 14, 2012")
    @listings[4].should == Listing.new("sales/sales060712.htm", "June 7, 2012")
    @listings[5].should == Listing.new("sales/sales053112.htm", "May 31, 2012")
    @listings[6].should == Listing.new("sales/sales052412.htm", "May 24, 2012")
    @listings[7].should == Listing.new("sales/sales051712.htm", "May 17, 2012")
    @listings[8].should == Listing.new("sales/sales051012.htm", "May 10, 2012")
    @listings[9].should == Listing.new("sales/sales050312.htm", "May 3, 2012")
    @listings[10].should == Listing.new("sales/sales042612.htm", "April 26, 2012")
    @listings[11].should == Listing.new("sales/sales041912.htm", "April 19, 2012")
    @listings[12].should == Listing.new("sales/sales041212.htm", "April 12, 2012")
    @listings[13].should == Listing.new("sales/sales040512.htm", "April 5, 2012")
  end
end