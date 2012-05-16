class Listing
  attr_accessor :link, :date
  
  def initialize()
  end
  
  def initialize(link, date)
    @link = link
    @date = date
  end
  
  def ==(other)
    self.link == other.link && self.date == other.date
  end
  
  def to_s
    "Listing<link='" + self.link + "', date='" + self.date + "'>"
  end
end