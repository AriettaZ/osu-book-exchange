class AddUserReferenceToMessages < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :messages, :users, column: :sender_id
  end
end
