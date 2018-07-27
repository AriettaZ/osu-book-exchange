# Author: Gail Chen
# Created: 7/25
# Edit: N/A
# Description: Test contract is expired and statuses of contract and post are changed.
# Test Plan:
# 1. If the contract is expired and status == "waiting",
#    then the contract is set to "declined" and the related post is set to "active".
# 2. If the contract is expired and status == "confirmed" or "declined" or "deleted",
#   then the statuses of contract and post are unchanged.
# 3. If the contract is not expired,
#   then the statuses of contract and the related post are unchanged.
require 'test_helper'

class DeclineExpiredContractJobTest < ActiveJob::TestCase
  # test 'contract is expired' do
  #   contract = Contract.last
  #   DeclineExpiredContractJob.perform_now(contract, User.find(contract.buyer_id), User.find(contract.seller_id))
  #   assert_equal Contract.last.status, "declined"
  #   assert_equal Post.find(Contract.last.post_id).status, "active"
  # end
end
