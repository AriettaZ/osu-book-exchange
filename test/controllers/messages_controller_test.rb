require 'test_helper'

class MessagesControllerTest < ActionDispatch::IntegrationTest
  test "should get list" do
    get '/profile/messages'
    assert_response :redirect
  end

  test "should get show" do
    get '/profile/messages'
    assert_response :redirect
  end

  test "should get new" do
    get '/profile/messages'
    assert_response :redirect
  end

  test "should get create" do
    get new_message_url
    assert_response :redirect
  end

end
