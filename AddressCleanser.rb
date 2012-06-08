require 'Geocoder'

class AddressCleanser
  def self.Cleanse(address)
    puts "Cleansing: #{address.rawAddress}"
    results = Geocoder.search(address.rawAddress)
    
    address.hasValidAddress = false
    
    if(!results.nil? && results.length > 0)
      result = results.first
      streetname = findProp(result, "route")
      streetNumber = findProp(result, "street_number")
      
      if(!streetname.nil? && !streetNumber.nil?)
        address.streetNumber = streetNumber["short_name"]
        address.streetName = streetname["short_name"]
        address.city = result.city
        address.state = result.state_code
        address.zip = result.postal_code
        address.latitude = result.latitude
        address.longitude = result.longitude
        address.hasValidAddress = true
      end
    end

    address.hasValidAddress
  end
  
  private
  
  def self.findProp(result, propName)
    result.address_components.select{|c| c["types"].include?(propName)}.first
  end
end