class CreateProddiscounts < ActiveRecord::Migration
  def self.up
    create_table :proddiscounts do |t|
      t.integer :prodid
      t.integer :discount
      t.date :discountfrom
      t.date :discountto

      t.timestamps
    end
  end

  def self.down
    drop_table :proddiscounts
  end
end
