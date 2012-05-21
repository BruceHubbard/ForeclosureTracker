class Auction
  attr_accessor :date, :plaintiff, :defendant, :address, :caseNumber, :appraised, :startingBid
  
  def to_s
    "Auction<date=#{self.date}, plaintiff=#{self.plaintiff}, address=#{self.address}, " +
    "appraised:#{self.appraised}, startingBid:#{self.startingBid}"
  end
end