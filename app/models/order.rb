class Order < ApplicationRecord
  belongs_to :contract
  enum status: {active: 0, problematic: 1, closed: 2, canceled: 3}
end
