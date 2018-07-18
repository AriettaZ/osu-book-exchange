class CreateContracts < ActiveRecord::Migration[5.2]
  def change
    create_table :contracts do |t|
      t.datetime :meeting_time
      t.text :meeting_address_first
      t.text :meeting_address_second
      t.integer :final_payment_method
      t.decimal :final_price
      t.datetime :expiration_time
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
