class CreateProductprices < ActiveRecord::Migration
  def self.up
    create_table :productprices do |t|
      t.integer :prodid
      t.integer :priceperunit
      t.integer :unit

      t.timestamps
    end
  end

  def self.down
    drop_table :productprices
  end
end
