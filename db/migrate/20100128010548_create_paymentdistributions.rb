class CreatePaymentdistributions < ActiveRecord::Migration
  def self.up
    create_table :paymentdistributions do |t|
      t.integer :payid
      t.integer :taxtypeid
      t.integer :taxamnt

      t.timestamps
    end
  end

  def self.down
    drop_table :paymentdistributions
  end
end
