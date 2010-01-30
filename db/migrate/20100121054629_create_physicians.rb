class CreatePhysicians < ActiveRecord::Migration
  def self.up
    create_table :physicians do |t|
      t.string :pname
      t.string :degree
      t.string :pgroup
      t.string :plicnum
      t.date :licexpdate

      t.timestamps
    end
  end

  def self.down
    drop_table :physicians
  end
end
