class AddContractReferenceToOrders < ActiveRecord::Migration[5.2]
  def change
    add_reference :orders, :contract, foreign_key: true
  end
end
