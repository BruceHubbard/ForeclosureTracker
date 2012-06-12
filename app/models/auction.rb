require 'active_record'

class Auction < ActiveRecord::Base
  after_initialize :init
  
  def init
    self.hasValidAddress ||= false
  end
  
  def fullAddress
    return !hasValidAddress ? 
              rawAddress : 
              "#{streetNumber} #{streetName}  #{city}, #{state} #{zip}"
  end
  
  def self.InvalidAddresses
    Auction.where(:hasValidAddress => false).all
  end
  
  def self.search(options)
    query = Auction.scoped
    query = query.where("appraised >= ?", options[:appraised_min]) if options[:appraised_min]
    query = query.where("appraised <= ?", options[:appraised_max]) if options[:appraised_max]
    query = query.where("date >= ?", Date.today) if !options[:showOld] || options[:showOld] == "false" 
    
    sort_col = options["sortProp"] || "date"
    sort_ord = options["sortDir"] || "asc"
    
    query = query.order("#{sort_col} #{sort_ord}")
    
    query.all
  end 
  
  def as_json(options = {})
    super.as_json(options).merge({:fullAddress => fullAddress})
  end
  
  def to_s
    "Auction<date=#{self.date}, plaintiff=#{self.plaintiff}, address=#{self.address}, " +
    "appraised:#{self.appraised}, startingBid:#{self.startingBid}"
  end
end
