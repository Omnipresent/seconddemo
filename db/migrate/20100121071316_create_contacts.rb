class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.string :cid
      t.string :hphone
      t.string :mphone
      t.string :provider
      t.string :cemail
      t.string :email
      t.string :sms
      t.string :mail
      t.string :group

      t.timestamps
    end
  end

  def self.down
    drop_table :contacts
  end
end
