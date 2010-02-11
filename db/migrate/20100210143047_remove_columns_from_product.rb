class RemoveColumnsFromProduct < ActiveRecord::Migration
  def self.up
  	remove_column :products, :prod_dis_per
  	remove_column :products, :prod_dis_price
  	remove_column :products, :prod_promo
  	add_column :products, :category_id, :integer
  	add_column :products, :type, :string
  	add_column :products, :conditions, :string
  	add_column :products, :rating, :string
  	add_column :products, :thc, :string
  	add_column :products, :volume, :string
  	add_column :products, :quantity, :integer
  	
  end

  def self.down
  end
end
