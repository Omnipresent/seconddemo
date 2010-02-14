class AddColumnToCartItem < ActiveRecord::Migration
  def self.up
  	add_column :cartitems, :status, :string
  	add_column :cartitems, :order_id, :integer
  end

  def self.down
  end
end
