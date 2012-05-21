require 'active_record'

class Auction < ActiveRecord::Base
  
  def to_s
    "Auction<date=#{self.date}, plaintiff=#{self.plaintiff}, address=#{self.address}, " +
    "appraised:#{self.appraised}, startingBid:#{self.startingBid}"
  end
end
