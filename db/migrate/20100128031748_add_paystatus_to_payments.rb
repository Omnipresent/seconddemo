class AddPaystatusToPayments < ActiveRecord::Migration
  def self.up
  	add_column :payments, :paystatus, :string
  end

  def self.down
  end
end
