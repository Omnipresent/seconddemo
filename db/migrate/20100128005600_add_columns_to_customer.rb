class AddColumnsToCustomer < ActiveRecord::Migration
  def self.up
  	add_column :customers, :suffix, :string
  	add_column :customers, :dlnstate, :string
  	add_column :customers, :dlnexpiry, :string
  end

  def self.down
  end
end
