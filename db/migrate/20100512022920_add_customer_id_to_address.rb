class AddCustomerIdToAddress < ActiveRecord::Migration
  def self.up
    add_column :addresses, :cid, :integer
  end

  def self.down
  end
end
