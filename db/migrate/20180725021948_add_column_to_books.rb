class AddColumnToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :description, :text
    add_column :books, :publisher, :text
    add_column :books, :subtitle, :text
    change_column :books, :edition, :integer, :default=>1
  end
end
