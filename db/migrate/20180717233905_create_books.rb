class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.text :ISBN_10
      t.text :ISBN_13
      t.text :edition
      t.text :title
      t.text :cover_image
      t.decimal :amazon_price

      t.timestamps
    end
  end
end
