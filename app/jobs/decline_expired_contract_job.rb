# Author: Gail Chen
# Created: 7/24
# Edit: N/A
# Description: The time to run this job (at the expiration time of the contract)
# is set in the controller. This job sets the contract to "declined" and the
# related post to "active" if the contract is expired and still waiting.
# After these updates, an email notification will be sent to both the buyer and seller.

class DeclineExpiredContractJob < ApplicationJob
  queue_as :default

  def perform(contract, signed_user, unsigned_user)
    @contract = contract
    post = Post.find(contract.post_id)

    if ((DateTime.now+1.second) >= contract.expiration_time) && (contract.status == "waiting")
      @contract.status = 2
      @contract.save
      post.status = 1
      post.save
      MagicMailer.contractDeclined(@contract, signed_user, unsigned_user).deliver_now
      MagicMailer.contractExpired(@contract, unsigned_user).deliver_now
    end
  end
end
