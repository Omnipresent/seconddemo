class DropCidFromCartitems < ActiveRecord::Migration
  def self.up
  	remove_column :cartitems, :cid
  end

  def self.down
  end
end
