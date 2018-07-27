class DeclineExpiredContractJob < ApplicationJob
  queue_as :default

  # If the contract is expired and it is not confirmed or declined, then decline the contract and send email notifications to users.
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
