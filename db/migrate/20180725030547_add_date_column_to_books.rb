class AddDateColumnToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :publication_date, :date
  end
end
