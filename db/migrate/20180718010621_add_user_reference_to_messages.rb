class AddUserReferenceToMessages < ActiveRecord::Migration[5.2]
  def change
    add_reference :messages, :sender, foreign_key: true
  end
end
