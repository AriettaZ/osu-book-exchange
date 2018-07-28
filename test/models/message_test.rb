require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  setup do
    @book = Book.create(title: "book_title", author: "Author")
    @user = User.create(email: "e@m", name: "C", password: "123456")
    @post = Post.create(book: @book, user: @user, condition: "New", post_type: "offer", payment_method: "inperson", price: 500, status: "closed")
    @user1 = User.create(email: "e@m", name: "C", password: "123456")
    @user2 = User.create(email: "m@e", name: "J", password: "654321")
  end

  test "proper message format should be valid" do
    @message = Message.new(sender: @user1, receiver: @user2, post: @post, content: "a"*501)
    assert_not @message.valid?, "Message with too long of content is valid."
    @message.content = " "
    assert_not @message.valid?, "Empty message was marked valid."
    @message.content = "Not blank"
    assert @message.valid?, @message.errors.full_messages#{}"Valid message was marked invalid."
    @message.sender = nil
    assert_not @message.valid?, "Message without sender is valid."
    @message.sender = @user1
    @message.receiver = nil
    assert_not @message.valid?, "Message without receiver is valid."
    @message.receiver = @user2
    @message.post = nil
    assert_not @message.valid?, "Message without post is valid."
  end

  test "can't message self" do
    @message = Message.new(sender: @user1, receiver: @user1, post: @post, content: "a"*500)
    assert_not @message.valid?, "Message with same sender/receiver is valid."
    @message.receiver = @user2
    assert @message.valid?, "Message with diff sender/receiver is invalid."
  end
end
