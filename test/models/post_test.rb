require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # setup runs before every single test
  setup do
    @book = Book.new(title: "book_title", author: "Author")
    @user = User.new(email: "e@m", name: "C", password: "123456")
    @post = Post.new(book: @book, user: @user, condition: "New", post_type: "offer", payment_method: "inperson", price: 500, status: "closed")
  end

  test "should require a book" do
    @post.book = nil
    assert_not @post.valid?, "Post saved without book."
    @post.book = @book
    assert @post.valid?, "Post with book not valid."
  end

  test "should require a user" do
    @post.user = nil
    assert_not @post.valid?, "Post saved without user."
    @post.user = @user
    assert @post.valid?, "Post with user not valid."
  end

  test "should require a condtion" do
    @post.condition = nil
    assert_not @post.valid?, "Post saved without condition."
    @post.condition = "Used - Very Good"
    assert @post.valid?, "Post with condition not valid."
  end

  test "should require a post_type" do
    @post.post_type = nil
    assert_not @post.valid?, "Post saved without post_type."
    @post.post_type = "request"
    assert @post.valid?, "Post with post_type not valid."
  end

  test "should require a payment_method" do
    @post.payment_method = nil
    assert_not @post.valid?, "Post saved without payment_method."
    @post.payment_method = "online"
    assert @post.valid?, "Post with payment_method not valid."
  end

  test "should require a price" do
    @post.price = nil
    assert_not @post.valid?, "Post saved without price."
    @post.price = -1
    assert_not @post.valid?, "Post with negative price valid."
    @post.price = 10001
    assert_not @post.valid?, "Post with too large of price valid."
    @post.price = 10000
    assert @post.valid?, "Post with max price not valid."
    @post.price = 0
    assert @post.valid?, "Post with min price not valid."
  end

  test "should require a status" do
    @post.status = nil
    assert_not @post.valid?, "Post saved without status."
    @post.status = "closed"
    assert @post.valid?, "Post with status was invalid."
  end
end
