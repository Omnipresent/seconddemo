class AddColumnsToOrderdetails < ActiveRecord::Migration
  def self.up
    add_column :orderdetails, :status, :string
	add_column :orderdetails, :cartid, :string
  end

  def self.down
    
  end
end
