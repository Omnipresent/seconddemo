class AddToStoreTable < ActiveRecord::Migration
  def self.up
  	add_column :stores, :created_by, :string
  end

  def self.down
  end
end
