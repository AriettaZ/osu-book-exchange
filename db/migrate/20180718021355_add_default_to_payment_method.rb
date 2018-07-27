class AddDefaultToPaymentMethod < ActiveRecord::Migration[5.2]
  def change
    change_column :posts, :payment_method, :integer, :default=>0
  end
end
