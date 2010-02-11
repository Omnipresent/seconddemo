class AddUserFirstNameUserLastNameUserStatus < ActiveRecord::Migration
  def self.up
  	add_column :users, :user_first_name, :string
  	add_column :users, :user_last_name, :string
  	add_column :users, :user_status, :string
  end

  def self.down
  end
end
