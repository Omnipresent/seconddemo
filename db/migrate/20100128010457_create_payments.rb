class CreatePayments < ActiveRecord::Migration
  def self.up
    create_table :payments do |t|
      t.integer :orderid
      t.integer :prodid
      t.integer :ttlprodcost
      t.string :paytype

      t.timestamps
    end
  end

  def self.down
    drop_table :payments
  end
end
