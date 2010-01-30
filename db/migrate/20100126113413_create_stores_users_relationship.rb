class CreateStoresUsersRelationship < ActiveRecord::Migration
  def self.up
    create_table :stores_users, :id => false do |t|
	    t.column :store_id, :integer
	    t.column :user_id, :integer   
	  end
  end

  def self.down		 	
	  drop_table :stores_users
  end
end
