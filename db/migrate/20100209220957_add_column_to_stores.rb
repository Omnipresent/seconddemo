class AddColumnToStores < ActiveRecord::Migration
  def self.up
  	add_column :stores, :store_status, :string
  end

  def self.down
  end
end
