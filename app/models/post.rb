class Post < ApplicationRecord
  extend FriendlyId
  friendly_id :book, use: :slugged
  belongs_to :book
  belongs_to :user
  has_many :images
  has_many :messages
  has_many :contracts
  enum post_type: {offer: 0, request: 1}
  enum payment_method: {inperson: 0, online: 1}
  enum status: {draft: 0, active: 1, pending: 2, closed: 3}
  enum condition: {"New": 0, "Used - Like New": 1, "Used - Very Good": 2, "Used - Good":3,"Used - Acceptable":4,"Unacceptable":5}

end
