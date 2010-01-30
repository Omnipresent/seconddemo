class CreateCustphyslinks < ActiveRecord::Migration
  def self.up
    create_table :custphyslinks do |t|
      t.string :customid
      t.string :physid
      t.string :prescid

      t.timestamps
    end
  end

  def self.down
    drop_table :custphyslinks
  end
end
