class AddTypeToCartitems < ActiveRecord::Migration
  def self.up
  	add_column :cartitems, :conditions, :string
  	add_column :cartitems, :prodtype, :string
  	add_column :cartitems, :rating, :string
  	add_column :cartitems, :thc, :string
  end

  def self.down
  end
end
