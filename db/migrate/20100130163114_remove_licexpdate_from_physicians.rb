class RemoveLicexpdateFromPhysicians < ActiveRecord::Migration
  def self.up
  	remove_column :physicians, :licexpdate
  	add_column :physicians, :licexpdate, :string
  	
  	remove_column :prescriptions, :recver
  	add_column :prescriptions, :recver, :string

  	remove_column :prescriptions, :recexp
  	add_column :prescriptions, :recexp, :string
  	
  	remove_column :proddiscounts, :discountfrom
  	add_column :proddiscounts, :discountfrom, :string

  	remove_column :proddiscounts, :discountto
  	add_column :proddiscounts, :discountto, :string
  	

  	
  end

  def self.down
  end
end
