class AddUserReferenceToContracts < ActiveRecord::Migration[5.2]
  def change
    add_reference :contracts, :seller, foreign_key: true
    add_reference :contracts, :buyer, foreign_key: true
    add_reference :contracts, :unsigned_user, foreign_key: true
    add_reference :contracts, :post, foreign_key: true
  end
end
