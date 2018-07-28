require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get root_url
    assert_response :success
  end

  test "should get about" do
    #get pages_about_url
    get '/about'
    assert_response :success
  end

  test "should get contact" do
    get '/profile/contacts'
    assert_response :redirect
  end

end
