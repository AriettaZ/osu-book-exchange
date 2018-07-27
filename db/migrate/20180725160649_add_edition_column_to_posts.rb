class AddEditionColumnToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :edition, :integer, :default=>1
  end
end
