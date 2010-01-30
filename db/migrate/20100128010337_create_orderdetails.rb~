class CreateOrderdetails < ActiveRecord::Migration
  def self.up
    create_table :orderdetails do |t|
      t.integer :orderid
      t.integer :prodid
      t.integer :productpriceid
      t.integer :proddiscountid
      t.integer :prodsaleprice
      t.integer :quantity
      t.string :status
      t.string :cartid

      t.timestamps
    end
  end

  def self.down
    drop_table :orderdetails
  end
end
