class CloseExpiredOrdersJob < ApplicationJob
  queue_as :default

  # If the contract is expired and it is not confirmed or declined,
  # then decline the contract and send email notifications to users.
  def perform(order)
    @order = order
    contract = Contract.find(order.contract_id)

    if @order.status == "active"
      @order.status = 2
      @order.save
      MagicMailer.orderCompleted(@order, User.find(contract.seller_id)).deliver_now
      MagicMailer.orderCompleted(@order, User.find(contract.buyer_id)).deliver_now
    end
  end
end
