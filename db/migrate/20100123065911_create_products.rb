class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string :prod_name
      t.decimal :prod_orig_price
      t.integer :prod_dis_per
      t.decimal :prod_dis_price
      t.string :prod_promo

      t.timestamps
    end
  end

  def self.down
    drop_table :products
  end
end
