# Author: Gail Chen
# Created: 7/23
# Edit: N/A
# Description: send emails to users when the status of their contracts and orders changed or messages sent
class MagicMailer < ApplicationMailer

  # Send an email to the user who started the contract.
  def newContract(contract, signed_user, unsigned_user)
    @contract = contract
    @signed_user = signed_user
    @unsigned_user = unsigned_user
    mail to: @signed_user.email, subject: "OSU Book Exchange -- New Contract Created"
  end

  # Send an email to the user that needs to confirm/decline a contract.
  def unsignedContract(contract, signed_user, unsigned_user)
    @contract = contract
    @signed_user = signed_user
    @unsigned_user = unsigned_user

    mail to: @unsigned_user.email, subject: "OSU Book Exchange -- New Contract to Sign"
  end

  def contractDeclined(contract, user, declinedBy)
    @contract = contract
    @user = user
    @declinedBy = declinedBy

    mail to: @user.email, subject: "OSU Book Exchange -- Contract##{@contract.id} Declined"
  end

  # Send an email to the users if a new order is placed.
  def newOrder(order, user)
    @order = order
    @user = user

    mail to: @user.email, subject: "OSU Book Exchange -- New Order##{@order.id} Placed"
  end

  # Send an email to users if the order is activated.
  def orderActive(order, user)
    @order = order
    @user = user

    mail to: @user.email, subject: "OSU Book Exchange -- Order##{@order.id} Activated"
  end

  # Send an email to magic team if the user reports a problem.
  def problematicOrder(order, user)
    @order = order
    @user = user

    mail to: "osu.magic.team@gmail.com", subject: "Problematic Order -- OSU Book Exchange"
  end

  # Send an email to users if the order is completed.
  def orderCompleted(order, user)
    @order = order
    @user = user

    mail to: @user.email, subject: "OSU Book Exchange -- Order##{@order.id} is Completed"
  end

  # Send an email to users if the order is canceled.
  def orderCanceled(order, user)
    @order = order
    @user = user

    mail to: @user.email, subject: "OSU Book Exchange -- Order##{@order.id} Canceled"
  end

  # Send an email to users if the order is canceled.
  def contact_us(message, user)
    @message = user
    @user = user

    mail to: "osu.magic.team@gmail.com", subject: "User Contacts Us -- OSU Book Exchange"
  end

  # Send an email to the message receiver
  def newMessage(message)
    @message = message

    mail to: "to@example.org"
  end
end
