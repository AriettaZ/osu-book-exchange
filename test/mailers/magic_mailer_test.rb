require 'test_helper'

class MagicMailerTest < ActionMailer::TestCase
  test "newContract" do
    mail = MagicMailer.newContract
    assert_equal "Newcontract", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "unsignedContract" do
    mail = MagicMailer.unsignedContract
    assert_equal "Unsignedcontract", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "newMessage" do
    mail = MagicMailer.newMessage
    assert_equal "Newmessage", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
