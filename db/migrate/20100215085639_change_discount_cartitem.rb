class ChangeDiscountCartitem < ActiveRecord::Migration
  def self.up
  	remove_column :cartitems, :discount
  	add_column :cartitems, :discount, :decimal
  end

  def self.down
  end
end
