require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should have a name" do
    @user = User.new(email: "e@m", name: nil, password: "123456")
    assert_not @user.valid?, "User saved without a name."
    @user.name = "Channing Jacobs"
    assert @user.valid?, "Failed to save user with a name."
  end

  test "should have an email" do
    @user = User.new(email: nil, name: "C", password: "123456")
    assert_not @user.valid?, "User saved without an email"
    @user.email = "@"
    assert_not @user.valid?, "Saved user with invalid email."
    @user.email = "e@m"
    assert @user.valid?, "Failed to save user with a valid email."
  end

  test "should have a password" do
    @user = User.new(email: "e@m", name: "C", password: nil)
    assert_not @user.valid?, "User saved without a password."
    @user.password = ""
    assert_not @user.valid?, "User saved with an empty password."
    @user.password = "12345"
    assert_not @user.valid?, "User saved with a short password."
    @user.password = "123456"
    assert @user.valid?, "User failed to saved with a valid password."
  end
  
end
