class AddFieldsToAuction < ActiveRecord::Migration
  def change
    add_column :auctions, :caseNumber, :string
    add_column :auctions, :appraised, :integer
    add_column :auctions, :startingBid, :integer
    add_column :auctions, :date, :datetime
  end
end
