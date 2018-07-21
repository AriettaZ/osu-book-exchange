class Message < ApplicationRecord
  belongs_to :sender, :class_name => 'User', :foreign_key => 'sender_id'
  belongs_to :receiver, :class_name => 'User', :foreign_key => 'receiver_id'
  belongs_to :post

  # Limit content of messages to 500 characters. Not empty.
  validates :content, presence: true, length: {maximum: 500}
end
