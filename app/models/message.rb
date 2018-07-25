# Channing 7/25 added prevention of messages to self
class Message < ApplicationRecord
  belongs_to :sender, :class_name => 'User', :foreign_key => 'sender_id'
  belongs_to :receiver, :class_name => 'User', :foreign_key => 'receiver_id'
  belongs_to :post

  # Limit content of messages to 500 characters. Not empty.
  validates :content, presence: true, length: {maximum: 500}
  # Prevent sending messages to self
  validate :check_diff_send_recv
  private
  def check_diff_send_recv
    errors.add(:sender, "can't be the same as receiver") if sender_id == receiver_id
  end
end
