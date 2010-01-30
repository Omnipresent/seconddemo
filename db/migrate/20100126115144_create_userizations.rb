class CreateUserizations < ActiveRecord::Migration
  def self.up
    create_table :userizations do |t|
      t.integer :user_id
      t.integer :store_id
      t.datetime :created_at

      t.timestamps
    end
  end

  def self.down
    drop_table :userizations
  end
end
