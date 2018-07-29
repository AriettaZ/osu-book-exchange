require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  setup do
    @book = Book.create(title: "book_title", author: "Author")
    @user1 = User.create(email: "e@m", name: "C", password: "123456")
    @user2 = User.create(email: "m@e", name: "J", password: "654321")
    @post = Post.create(book: @book, user: @user1, condition: "New", post_type: "offer", payment_method: "inperson", price: 500)
    @seller = @user1
    @buyer = @user2
    @unisgned_user = @buyer
    @contract = Contract.create(seller: @seller, buyer: @buyer,
      unsigned_user: @unsigned_user, post: @post, status: "waiting",
      final_payment_method: "inperson", meeting_address_first: "location",
      meeting_time: "11AM", final_price: "29.99",
      expiration_time: "2018-02-03 01:05:00")
    @order = Order.new(contract: @contract, status: "active")
  end

  test "order should have contract" do
    @order.contract_id = nil
    assert_not @order.valid?, "Order without contract was valid."
    @order.contract = @contract
    assert @order.valid?, "Order with contract was invalid."
  end

  test "order should have status" do
    @order.status = nil
    assert_not @order.valid?, "Order without status was valid."
    @order.status = "problematic"
    assert @order.valid?, "Order with status was invalid."
  end

end
