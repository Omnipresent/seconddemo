class ChangeColumnCartitems < ActiveRecord::Migration
  def self.up
  	remove_column :cartitems, :price
  	add_column :cartitems, :price, :numeric
  end

  def self.down
  end
end
