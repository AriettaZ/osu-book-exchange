class RemoveEditionColumnColumnFromBooks < ActiveRecord::Migration[5.2]
  def change
    remove_column :books, :edition
  end
end
