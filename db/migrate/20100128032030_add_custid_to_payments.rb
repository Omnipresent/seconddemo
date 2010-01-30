class AddCustidToPayments < ActiveRecord::Migration
  def self.up
  	add_column :payments, :custid, :integer
  end

  def self.down
  end
end
