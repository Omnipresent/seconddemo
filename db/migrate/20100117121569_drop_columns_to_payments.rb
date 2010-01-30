class DropColumnsToPayments < ActiveRecord::Migration
  def self.up
    remove_column :payments, :ttlprodcost
    add_column :payments, :ttlprodcost, :string

  end

  def self.down
    
  end
end
