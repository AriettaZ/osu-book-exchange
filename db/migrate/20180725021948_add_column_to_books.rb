class AddColumnToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :description, :text
    add_column :books, :publisher, :text
    add_column :books, :subtitle, :text
  end
end
