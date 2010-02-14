class AddVolumeToCartitem < ActiveRecord::Migration
  def self.up
  	add_column :cartitems, :volume, :string
  end

  def self.down
  end
end
