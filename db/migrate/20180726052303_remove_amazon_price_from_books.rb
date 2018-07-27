class RemoveAmazonPriceFromBooks < ActiveRecord::Migration[5.2]
  def change
    remove_column :books, :amazon_price
  end
end
