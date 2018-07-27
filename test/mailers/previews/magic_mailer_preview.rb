# Author: Gail Chen
# Created: 7/23
# Edit: 7/24 Gail added contractExpired
# Description: Preview emails.

# Preview all emails at http://localhost:3000/rails/mailers/magic_mailer
class MagicMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/magic_mailer/newContract
  def newContract
    contract = Contract.last
    MagicMailer.newContract(contract, User.first, User.last)
  end

  # Preview this email at http://localhost:3000/rails/mailers/magic_mailer/unsignedContract
  def unsignedContract
    contract = Contract.last
    MagicMailer.unsignedContract(contract, User.first, User.last)
  end

  # Preview this email at http://localhost:3000/rails/mailers/magic_mailer/contractDeclined
  def contractDeclined
    contract = Contract.last
    user = User.find(Contract.last.buyer_id)
    declinedBy = User.find(Contract.last.seller_id)

    MagicMailer.contractDeclined(contract, user, declinedBy)
  end

  # Preview this email at http://localhost:3000/rails/mailers/magic_mailer/contractExpired
  def contractExpired
    contract = Contract.last
    user = User.find(Contract.last.buyer_id)

    MagicMailer.contractExpired(contract, user)
  end

  # Preview this email at http://localhost:3000/rails/mailers/magic_mailer/newOrder
  def newOrder
    order = Order.last
    user = User.find(Contract.find(order.contract_id).buyer_id)
    MagicMailer.newOrder(order, user)
  end

  # Preview this email at http://localhost:3000/rails/mailers/magic_mailer/orderActive
  def orderActive
    order = Order.last
    user = User.find(Contract.find(order.contract_id).buyer_id)
    MagicMailer.orderActive(order, user)
  end

  # Preview this email at http://localhost:3000/rails/mailers/magic_mailer/problematicOrder
  def problematicOrder
    order = Order.last
    user = User.find(Contract.find(order.contract_id).buyer_id)
    MagicMailer.problematicOrder(order, user)
  end

  # Preview this email at http://localhost:3000/rails/mailers/magic_mailer/orderCompleted
  def orderCompleted
    order = Order.last
    user = User.find(Contract.find(order.contract_id).buyer_id)
    MagicMailer.orderCompleted(order, user)
  end

  # Preview this email at http://localhost:3000/rails/mailers/magic_mailer/orderCanceled.html
   def orderCanceled
     order = Order.last
     user = User.find(Contract.find(order.contract_id).buyer_id)
     MagicMailer.orderCanceled(order, user)
  end

  # Preview this email at http://localhost:3000/rails/mailers/magic_mailer/newMessage
  def newMessage
    message = Message.last

    MagicMailer.newMessage(message)
  end

end
