class ChangeIsbn10FromBook < ActiveRecord::Migration[5.2]
  def change
    rename_column :books, :isbn10, :ISBN_10
    rename_column :books, :isbn13, :ISBN_13
    add_column :books, :list_price, :decimal
  end
end
