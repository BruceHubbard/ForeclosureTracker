require './ButlerAuctionParser.rb'
require './app/models/Auction.rb'
require 'support/active_record'

describe ButlerAuctionParser do
  before(:each) do
    @mockInput = File.open("./spec/butler_07_21_small.html", "rb").read
    @parser = ButlerAuctionParser.new(@mockInput)
    @auctions = @parser.auctions
  end
  
  it "returns 3 auctions" do
    @auctions.length.should == 3
  end
  
  it "returns auction objects" do
    for auction in @auctions do auction.should be_a(Auction) end
  end
  
  it 'returns first auction correctly' do
    @auctions[0].date.should be_a(DateTime)
    @auctions[0].date.month.should == 7
    @auctions[0].date.day.should == 12
    @auctions[0].date.year.should == 2012
    
    @auctions[0].plaintiff.should == "NANCY E. NIX, TREASURER"
    @auctions[0].defendant.should == "WILLIAM F. BURGER, JR., ET AL"
    @auctions[0].rawAddress.should == "2016 ARLINGTON AVE., MIDDLETOWN 45042"
    @auctions[0].caseNumber.should == "CV08083858"
    @auctions[0].appraised.should == 8252
    @auctions[0].startingBid.should == 0
  end
  
  it 'returns second auction correctly' do
    @auctions[1].date.should be_a(DateTime)
    @auctions[1].date.month.should == 7
    @auctions[1].date.day.should == 12
    @auctions[1].date.year.should == 2012

    @auctions[1].plaintiff.should == "BAC HOME LOANS SERVICING, LP..."
    @auctions[1].defendant.should == "CARL FREDERICK COCKERHAM, ET AL"
    @auctions[1].rawAddress.should == "4534 BONITA DR., #183, MIDDLETOWN 45044"
    @auctions[1].caseNumber.should == "CV10052049"
    @auctions[1].appraised.should == 64200
    @auctions[1].startingBid.should == 42800
  end

  it 'returns 3rd auction correctly' do
    @auctions[2].plaintiff.should == "NANCY E. NIX, TREASURER"
    @auctions[2].defendant.should == "JAMES R. RYE, ET AL."
    @auctions[2].rawAddress.should == "514 S &quot;B&quot; STREET, HAMILTON, OH 45013"
    @auctions[2].caseNumber.should == "CV11103730"
    @auctions[2].appraised.should == 7949
    @auctions[2].startingBid.should == 0
  end
end