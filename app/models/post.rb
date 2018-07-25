# Channing 7/25 added new validates and removed extra validates
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
    text :edition

    integer :price
  end
  validates :price, numericality: { less_than_or_equal_to: 10000, greater_than_or_equal_to: 0 }
  validates_presence_of :condition
  validates_presence_of :post_type
  validates_presence_of :payment_method
  validates_presence_of :status
  validates :edition, numericality: {less_than_or_equal_to: 100, greater_than_or_equal_to: 0}
end
