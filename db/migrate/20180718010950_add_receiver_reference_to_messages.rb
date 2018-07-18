class AddReceiverReferenceToMessages < ActiveRecord::Migration[5.2]
  def change
    add_reference :messages, :receiver, foreign_key: true
  end
end
