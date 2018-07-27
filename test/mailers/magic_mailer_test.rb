# Author: Gail Chen
# Created: 7/23
# Edit: N/A
# Description: Test the email sent.

require 'test_helper'

class MagicMailerTest < ActionMailer::TestCase
  test "newContract" do
    mail = MagicMailer.newContract
    assert_equal ["osu.magic.team@gmail.com"], mail.from
  end

  test "unsignedContract" do
    mail = MagicMailer.unsignedContract
    assert_equal ["osu.magic.team@gmail.com"], mail.from
  end

  test "contractDeclined" do
    mail = MagicMailer.newMessage
    assert_equal ["osu.magic.team@gmail.com"], mail.from
  end

  test "contractExpired" do
    mail = MagicMailer.newMessage
    assert_equal ["osu.magic.team@gmail.com"], mail.from
  end

  test "newOrder" do
    mail = MagicMailer.newMessage
    assert_equal ["osu.magic.team@gmail.com"], mail.from
  end

  test "orderActive" do
    mail = MagicMailer.newMessage
    assert_equal ["osu.magic.team@gmail.com"], mail.from
  end

  test "problematicOrder" do
    mail = MagicMailer.newMessage
    assert_equal "Newmessage", mail.subject
    assert_equal ["osu.magic.team@gmail.com"], mail.to
    assert_equal ["osu.magic.team@gmail.com"], mail.from
  end

  test "orderCompleted" do
    mail = MagicMailer.newMessage
    assert_equal ["osu.magic.team@gmail.com"], mail.from
  end

  test "orderCanceled" do
    mail = MagicMailer.newMessage
    assert_equal ["osu.magic.team@gmail.com"], mail.from
  end

  test "newMessage" do
    mail = MagicMailer.newMessage
    assert_equal ["osu.magic.team@gmail.com"], mail.from
  end

end
