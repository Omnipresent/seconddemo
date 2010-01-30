class AddCidToCartitems < ActiveRecord::Migration
  def self.up
  	add_column :cartitems, :cid, :integer
  end

  def self.down
  end
end
