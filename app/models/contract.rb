class Contract < ApplicationRecord
  belongs_to :seller, :class_name => 'User', :foreign_key => 'seller_id'
  belongs_to :buyer, :class_name => 'User', :foreign_key => 'buyer_id'
  belongs_to :unsigned_user, :class_name => 'User', :foreign_key => 'unsigned_user'
  belongs_to :post
  has_one :order
  enum status: {waiting: 0, confirmed: 1, declined: 2}
  enum final_payment_method: {inperson: 0, online: 1}
end
