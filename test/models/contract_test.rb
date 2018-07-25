require 'test_helper'

class ContractTest < ActiveSupport::TestCase
  setup do
    @book = Book.create(title: "book_title")
    @user1 = User.create(email: "e@m", name: "C", password: "123456")
    @user2 = User.create(email: "e@m", name: "C", password: "123456")
    @post = Post.create(book: @book, user: @user1, condition: "New", post_type: "offer", payment_method: "inperson", price: 500)
    @seller = @user1
    @buyer = @user2
    @unisgned_user = @buyer
    @contract = Contract.new(seller: @seller, buyer: @buyer,
      unsigned_user: @unsigned_user, post: @post, status: "waiting",
      final_payment_method: "inperson", meeting_address_first: "location",
      meeting_time: "11AM", final_price: "29.99",
      expiration_time: "2018-02-03 01:05:00")
  end

  test "correctly setup contract should be valid" do
    assert @contract.valid?, @contract.errors.messages
  end

end
