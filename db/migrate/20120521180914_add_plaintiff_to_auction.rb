class AddPlaintiffToAuction < ActiveRecord::Migration
  def change
    add_column :auctions, :plaintiff, :string
  end
end
