class RemoveColumnProducts < ActiveRecord::Migration
  def self.up
  	remove_column :products, :userid
  	remove_column :products, :storeid
  end

  def self.down
  end
end
