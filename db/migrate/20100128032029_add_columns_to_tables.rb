class AddColumnsToTables < ActiveRecord::Migration
  def self.up
    add_column :addresses, :userid, :integer
	add_column :addresses, :storeid, :integer
	 add_column :contacts, :userid, :integer
	add_column :contacts, :storeid, :integer
	 add_column :customers, :userid, :integer
	add_column :customers, :storeid, :integer
	 add_column :orderdetails, :userid, :integer
	add_column :orderdetails, :storeid, :integer
	 add_column :orders, :userid, :integer
	add_column :orders, :storeid, :integer
	 add_column :paymentdistributions, :userid, :integer
	add_column :paymentdistributions, :storeid, :integer
	 add_column :payments, :userid, :integer
	add_column :payments, :storeid, :integer
	 add_column :physicians, :userid, :integer
	add_column :physicians, :storeid, :integer
	 add_column :prescriptions, :userid, :integer
	add_column :prescriptions, :storeid, :integer
	 add_column :products, :userid, :integer
	add_column :products, :storeid, :integer


  end

  def self.down
    
  end
end
