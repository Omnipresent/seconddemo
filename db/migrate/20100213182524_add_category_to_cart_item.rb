class AddCategoryToCartItem < ActiveRecord::Migration
  def self.up
  	add_column :cartitems, :category_name, :string
  end

  def self.down
  end
end
