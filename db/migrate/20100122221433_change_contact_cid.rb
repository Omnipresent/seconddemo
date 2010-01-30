class ChangeContactCid < ActiveRecord::Migration
  def self.up
  	remove_column :contacts, :cid
  	add_column :contacts, :cid, :integer
  end

  def self.down
  end
end
