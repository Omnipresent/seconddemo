class ChangeContactCid < ActiveRecord::Migration
  def self.up
  	drop_column :contacts, :cid, :integer
  	add_column :contacts, :cid, :integer
  end

  def self.down
  end
end
