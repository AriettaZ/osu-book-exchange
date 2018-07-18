class AddPostReferenceToMessages < ActiveRecord::Migration[5.2]
  def change
    add_reference :messages, :post, foreign_key: true
  end
end
