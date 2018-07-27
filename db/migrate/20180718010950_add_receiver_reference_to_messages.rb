class AddReceiverReferenceToMessages < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :messages, :users, column: :receiver_id
  end
end
