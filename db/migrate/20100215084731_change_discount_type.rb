class ChangeDiscountType < ActiveRecord::Migration
  def self.up
  	remove_column :proddiscounts, :discount
  	add_column :proddiscounts, :discount, :decimal
  end

  def self.down
  end
end
