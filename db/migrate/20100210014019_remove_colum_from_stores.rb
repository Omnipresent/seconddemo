class RemoveColumFromStores < ActiveRecord::Migration
  def self.up
  	remove_column :stores, :store_id
  end

  def self.down
  end
end
