class Order < ApplicationRecord
  belongs_to :contract
  enum status: {active: 0, problematic: 1, completed: 2, canceled: 3}
  validates_presence_of :status
end
