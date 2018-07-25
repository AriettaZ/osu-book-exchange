class AddBookReferenceToAuthor < ActiveRecord::Migration[5.2]
  def change
    add_reference :authors, :book, foreign_key: true
  end
end
