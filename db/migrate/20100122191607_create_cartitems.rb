class CreateCartitems < ActiveRecord::Migration
  def self.up
    create_table :cartitems do |t|
      t.string :cid
      t.string :pid
      t.string :ptype
      t.string :itemname
      t.string :quality
      t.string :quantity
      t.integer :price
      t.integer :discount

      t.timestamps
    end
  end

  def self.down
    drop_table :cartitems
  end
end
