class AddPostRefToBookmarks < ActiveRecord::Migration[5.2]
  def change
    add_reference :bookmarks, :post, foreign_key: true
  end
end
