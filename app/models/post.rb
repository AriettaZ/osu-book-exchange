class Post < ApplicationRecord
  belongs_to :book
  belongs_to :user
  enum type: {offer: 0, request: 1}
  enum payment_method: {inperson: 0, online: 1}
  enum status: {active: 0, pending: 1, closed: 2}
end
