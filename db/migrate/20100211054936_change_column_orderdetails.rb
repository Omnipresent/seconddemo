class ChangeColumnOrderdetails < ActiveRecord::Migration
  def self.up
  	remove_column :orderdetails, 	:prodsaleprice
  	add_column :orderdetails, :prodsaleprice, :numeric
  end

  def self.down
  end
end
