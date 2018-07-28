# Gail 7/19 added validation
class Order < ApplicationRecord
  belongs_to :contract
  enum status: {active: 0, problematic: 1, completed: 2, canceled: 3,deleted: 4}
  validates_presence_of :status
  validates_presence_of :contract_id
end
