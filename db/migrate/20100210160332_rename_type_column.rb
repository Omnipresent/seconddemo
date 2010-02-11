class RenameTypeColumn < ActiveRecord::Migration
  def self.up
		remove_column :products, :type
		add_column :products, :prod_type, :string
  end

  def self.down
  end
end
