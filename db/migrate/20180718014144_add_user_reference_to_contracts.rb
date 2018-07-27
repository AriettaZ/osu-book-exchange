class AddUserReferenceToContracts < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :contracts, :users, column: :unsigned_user_id
    add_foreign_key :contracts, :users, column: :buyer_id
    add_foreign_key :contracts, :users, column: :seller_id
    add_reference :contracts, :post, foreign_key: true
  end
end
