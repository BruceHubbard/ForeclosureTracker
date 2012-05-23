require 'active_record'

class Auction < ActiveRecord::Base
  scope :by_appraised_min, lambda { |min| }


  def self.search(options)
    query = Auction.scoped
    query = query.where("appraised >= ?", options[:appraised_min]) if options[:appraised_min]
    query = query.where("appraised <= ?", options[:appraised_max]) if options[:appraised_max]
    
    sort_col = options["sort_col"] || "date"
    sort_ord = options["sort_ord"] || "asc"
    
    query = query.order("#{sort_col} #{sort_ord}")
    
    query.all
  end 
  
  def to_s
    "Auction<date=#{self.date}, plaintiff=#{self.plaintiff}, address=#{self.address}, " +
    "appraised:#{self.appraised}, startingBid:#{self.startingBid}"
  end
end
