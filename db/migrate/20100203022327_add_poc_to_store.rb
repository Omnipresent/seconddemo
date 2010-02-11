class AddPocToStore < ActiveRecord::Migration
  def self.up
  	add_column :stores, :store_poc, :string
  end

  def self.down
  end
end
