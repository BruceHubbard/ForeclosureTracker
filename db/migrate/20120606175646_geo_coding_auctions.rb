class GeoCodingAuctions < ActiveRecord::Migration
  def change
    rename_column :auctions, :address, :rawAddress
    
    add_column :auctions, :latitude, :float
    add_column :auctions, :longitude, :float
    add_column :auctions, :streetNumber, :string
    add_column :auctions, :streetName, :string
    add_column :auctions, :city, :string
    add_column :auctions, :state, :string
    add_column :auctions, :zip, :string
    add_column :auctions, :hasValidAddress, :boolean
  end
end
