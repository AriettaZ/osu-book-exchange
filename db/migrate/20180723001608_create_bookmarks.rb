class CreateBookmarks < ActiveRecord::Migration[5.2]
  def change
    create_table :bookmarks do |t|
      t.boolean :favorite
      t.timestamps
    end
  end
end
