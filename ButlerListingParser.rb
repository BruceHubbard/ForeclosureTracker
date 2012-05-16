require 'nokogiri'
require './app/models/Listing.rb'

class ButlerListingParser
  def initialize(html)
    @html = Nokogiri::HTML.parse(html)
  end
  
  def listings
    list = []
    for link in @html.css('#AutoNumber1 a') do
      list << Listing.new(link["href"], link.content.gsub(/\n\t/, "").gsub(/\s+/, " ").strip)
    end
    
    list
  end
end