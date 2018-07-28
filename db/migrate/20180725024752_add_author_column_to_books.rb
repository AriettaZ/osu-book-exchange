class AddAuthorColumnToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :author, :text
  end
end
