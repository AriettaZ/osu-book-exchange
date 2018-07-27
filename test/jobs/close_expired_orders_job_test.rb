# Author: Gail Chen
# Created: 7/25
# Edit: N/A
# Description: The time to run iTest the order is expired(passed the meeting time) and status of order is set to "completed"
# Test Plan:
# 1. If the order is expired and status == "active",
#   then the order is set to "completed".
# 2. If the order is expired and status == "problematic" or "completed" or "canceled",
#   then the order status is unchanged.
# 3. If the contract is not expired,
#   then the order status is unchanged.

require 'test_helper'

class CloseExpiredOrdersJobTest < ActiveJob::TestCase
  # test 'order is expired' do
  #   CloseExpiredOrdersJob.perform_now(Order.first)
  #   assert_equal Order.first.status, "completed"
  # end
end
