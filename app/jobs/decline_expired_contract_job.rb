class DeclineExpiredContractJob < ApplicationJob
  queue_as :default

  def perform(contract_id)
    contract = Contract.find(contract_id)
    post = Post.find(contract.post_id)
    expiration = contract.expiration_time
    if DateTime.now > exipration && contract.status == "waiting"
      contract.status = 2
      post.status = 1
      contract.save
      post.save
    end
  end
end
