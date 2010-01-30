class ChangeDobDateToTimeStamp < ActiveRecord::Migration
  def self.up
    remove_column :customers, :dob
    add_column :customers, :dob, :string
  end

  def self.down
  end
end
