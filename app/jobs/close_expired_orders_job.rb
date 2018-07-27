# Author: Gail Chen
# Created: 7/24
# Edit: N/A
# Description: The time to run this job (three days after the meeting time) is set in the controller.
# This job set the status of the order to "active" if it is not "completed", "problematic", or "canceled".
# After these update, an email notification will be sent to both the buyer and seller.

class CloseExpiredOrdersJob < ApplicationJob
  queue_as :default

  def perform(order)
    @order = order
    contract = Contract.find(order.contract_id)

    if (DateTime.now > contract.meeting_time) && (@order.status == "active")
      @order.status = 2
      @order.save
      MagicMailer.orderCompleted(@order, User.find(contract.seller_id)).deliver_now
      MagicMailer.orderCompleted(@order, User.find(contract.buyer_id)).deliver_now
    end
  end
end
