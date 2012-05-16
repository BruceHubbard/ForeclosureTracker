require './app/models/Auction.rb'

class ButlerAuctionParser
  
  @@val_start = "<span"
  
  def initialize(text)
    @text = text
  end
  
  def auctions
    formatted = split_auctions
    auctions = []
    for a in formatted
      parsed = parse_auction(a)
      
      if(parsed != nil) then auctions << parsed end
    end
    auctions
  end
  
  private

  def parse_auction(a)
    plaintiff = find_value(a, "Plaintiff:")
    if(plaintiff == nil) then return nil end
      
    auction = Auction.new
    auction.date = find_value(a, "Date:")
    auction.plaintiff = plaintiff
    auction.defendant = find_value(a, "Defendant:")
    auction.address = find_value(a, "Address:")
    auction.caseNumber = find_value(a, "# :")
    auction.appraised = find_value(a, "Appraised:").to_i
    auction.startingBid = find_value(a, "Starting Bid:").to_i
    
    return auction
  end
  
  def find_value(a, label)
    marker_start = a.index(label)
    if(marker_start == nil || a.index(@@val_start, marker_start) == nil) then return nil end
    start_pos = a.index(@@val_start, marker_start) + @@val_start.length
    start_pos = a.index(">", start_pos) + 1
    a[start_pos..a.index("</span>", start_pos)-1]
  end

  def split_auctions
    main_content.split("<p class=MsoNormal><o:p>&nbsp;</o:p></p>")
  end
  
  def main_content
    start = @text.index("<div class=WordSection1>")
    end_pos = @text.index("</div>", start)
    @text[start,end_pos]
  end
end