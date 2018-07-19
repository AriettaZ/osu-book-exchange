require 'test_helper'

class DashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get myorder" do
    get dashboard_myorder_url
    assert_response :success
  end

  test "should get myrequest" do
    get dashboard_myrequest_url
    assert_response :success
  end

  test "should get myoffer" do
    get dashboard_myoffer_url
    assert_response :success
  end

  test "should get account_information" do
    get dashboard_account_information_url
    assert_response :success
  end

  test "should get messages" do
    get dashboard_messages_url
    assert_response :success
  end

  test "should get bookmarks" do
    get dashboard_bookmarks_url
    assert_response :success
  end

end
