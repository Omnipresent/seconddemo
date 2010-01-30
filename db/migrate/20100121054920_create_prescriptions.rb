class CreatePrescriptions < ActiveRecord::Migration
  def self.up
    create_table :prescriptions do |t|
      t.date :recver
      t.date :recexp
      t.string :physver

      t.timestamps
    end
  end

  def self.down
    drop_table :prescriptions
  end
end
