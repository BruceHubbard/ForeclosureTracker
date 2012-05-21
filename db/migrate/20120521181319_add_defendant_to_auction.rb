class AddDefendantToAuction < ActiveRecord::Migration
  def change
    add_column :auctions, :defendant, :string
  end
end
