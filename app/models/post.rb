class Post < ApplicationRecord
  belongs_to :book
  accepts_nested_attributes_for :book
  belongs_to :user
  has_many :images
  has_many :bookmarks
  # Also has many :users, through: :bookmarks
  accepts_nested_attributes_for :images
  has_many :messages
  has_many :contracts
  enum post_type: {offer: 0, request: 1}
  enum payment_method: {inperson: 0, online: 1}
  enum status: {draft: 0, active: 1, pending: 2, closed: 3}
  enum condition: {"New": 0, "Used - Like New": 1, "Used - Very Good": 2, "Used - Good":3,"Used - Acceptable":4,"Unacceptable":5}
  searchable do
    text :condition
    text :description
    text :post_type
    text :payment_method
    text :status
    text :book_id

    integer :price
  end
  validates :price, numericality: { less_than: 10000 }
  validates :book, presence: true
end
