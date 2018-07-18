class AddContractReferenceToOrders < ActiveRecord::Migration[5.2]
  def change
    add_reference :orders, :contract, foreign_key: true
    change_column :contacts, :status, :integer, :default => 0
    change_column :posts, :status, :integer, :default => 0
    change_column :posts, :condition, :integer, :default => 0
    rename_column :posts, :type, :post_type, :default => 0
  end
end
