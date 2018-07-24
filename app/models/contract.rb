class Contract < ApplicationRecord
  belongs_to :seller, :class_name => 'User', :foreign_key => 'seller_id'
  belongs_to :buyer, :class_name => 'User', :foreign_key => 'buyer_id'
  belongs_to :unsigned_user, :class_name => 'User', :foreign_key => 'unsigned_user_id', optional: true
  belongs_to :post
  has_one :order
  enum status: {waiting: 0, confirmed: 1, declined: 2, deleted: 3}
  enum final_payment_method: {inperson: 0, online: 1}
  validates :meeting_address_first, presence: true
  validates :final_price, presence: true, format: { with: /\A\d+(?:\.\d{0,2})?\z/ }, numericality: { greater_than: 0, less_than: 10000 }
  validates :meeting_time, presence: true
  validates :expiration_time, presence: true
  validates :final_price, numericality: { less_than: 10000 }
end
