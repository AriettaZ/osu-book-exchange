# Preview all emails at http://localhost:3000/rails/mailers/magic_mailer
class MagicMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/magic_mailer/newContract
  def newContract
    contract = Contract.last
    user = User.find(contract.unsigned_user_id)
    MagicMailer.newContract(contract, user)
  end

  # Preview this email at http://localhost:3000/rails/mailers/magic_mailer/unsignedContract
  def unsignedContract
    contract = Contract.last
    MagicMailer.unsignedContract(contract)
  end

  # Preview this email at http://localhost:3000/rails/mailers/magic_mailer/newMessage
  def newMessage
    MagicMailer.newMessage
  end

end
