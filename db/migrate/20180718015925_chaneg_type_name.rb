class ChanegTypeName < ActiveRecord::Migration[5.2]
  def change
    change_column :contracts, :status, :integer, :default => 0
    change_column :posts, :status, :integer, :default => 0
    change_column :posts, :condition, :integer, :default => 0
    rename_column :posts, :type, :post_type
  end
end
