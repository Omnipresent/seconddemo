class CreateContactlinks < ActiveRecord::Migration
  def self.up
    create_table :contactlinks do |t|
      t.string :contactid
      t.string :addressid

      t.timestamps
    end
  end

  def self.down
    drop_table :contactlinks
  end
end
