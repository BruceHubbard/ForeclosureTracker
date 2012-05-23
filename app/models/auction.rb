require 'active_record'

class Auction < ActiveRecord::Base
  scope :by_appraised_min, lambda { |min| }


  def self.search(options)
    query = Auction.scoped
    query = query.where("appraised >= ?", options[:appraised_min]) if options[:appraised_min]
    query = query.where("appraised <= ?", options[:appraised_max]) if options[:appraised_max]
    query.all
  end 
  
  def to_s
    "Auction<date=#{self.date}, plaintiff=#{self.plaintiff}, address=#{self.address}, " +
    "appraised:#{self.appraised}, startingBid:#{self.startingBid}"
  end
end
