class CreateCustomers < ActiveRecord::Migration
  def self.up
    create_table :customers do |t|
      t.string :lastname
      t.string :firstname
      t.date :dob
      t.string :dln
      t.string :sex
      t.string :referral
      t.string :reffredby
      t.string :notes
      t.string :statemmp
      t.string :recom
      t.string :countyid

      t.timestamps
    end
  end

  def self.down
    drop_table :customers
  end
end
