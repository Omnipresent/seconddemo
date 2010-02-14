class AddPhoneToContacts < ActiveRecord::Migration
  def self.up
  	  	add_column :contacts, :phone, :string
  end

  def self.down
  end
end
