require 'test_helper'

class DashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get myorder" do
    get profile_myorder_url
    assert_response :redirect
  end

  test "should get myrequest" do
    get profile_myrequest_url
    assert_response :redirect
  end

  test "should get myoffer" do
    get profile_myoffer_url
    assert_response :redirect
  end

  test "should get account_information" do
    get account_information_url
    assert_response :redirect
  end

  test "should get messages" do
    get profile_messages_url
    assert_response :redirect
  end

  test "should get bookmarks" do
    get profile_bookmarks_url
    assert_response :redirect
  end

end
