class ChangeContactCid < ActiveRecord::Migration
  def self.up
  	add_column :contacts, :cid, :integer
  end

  def self.down
  end
end
