class MagicMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.magic_mailer.newContract.subject
  #
  def newContract(contract, signed_user)
    @contract = contract
    @user = signed_user

    mail to: user.email, subject: "New Contract Created"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.magic_mailer.unsignedContract.subject
  #
  def unsignedContract(contract, unsigned_user)
    @contract = contract
    @user = unsigned_user

    mail to: @user.email, subject: "New Contract to Sign"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.magic_mailer.newMessage.subject
  #
  def newMessage
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
