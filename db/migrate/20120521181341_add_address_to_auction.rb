class AddAddressToAuction < ActiveRecord::Migration
  def change
    add_column :auctions, :address, :string
  end
end
