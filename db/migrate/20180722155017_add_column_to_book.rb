class AddColumnToBook < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :self_link, :text
  end
end
