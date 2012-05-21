class CreateAuctions < ActiveRecord::Migration
  def change
    create_table :auctions do |t|
      
      t.timestamps
    end
  end
end
