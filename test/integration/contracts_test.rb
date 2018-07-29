require 'test_helper'
# # require 'devise'
class ContractsTest < ActionDispatch::IntegrationTest
#   include Devise::Test::IntegrationHelpers
#
#   setup do
#     # @contract = contracts(:one)
#     # @contracts = Contract.all
#     # x = users(:admin)
#     @user = User.find_by_name("Channing Jacobs")
#     @user.encrypted_password = User.new.send(:password_digest, 'password')
#     sign_in(@user)
# #
#     #@user= users(:admin)
#   #   # @request.env["devise.mapping"] = Devise.mappings[:user]
#   #   #sign_in @user
#   end
#   #
#   test "should get index integration" do
#     get profile_url
#     assert_response :redirect
#   #   # get 'http://localhost:3000/login' #, :user => {name: @user.name, password: "password"}
#   #   # assert_response :success
#   #   # post 'http://localhost:3000/login', params: { name: "Channing Jacobs", password: "password" }
#   #   # assert_response :success
#   #
#   #   # get contracts_url
#   #   # assert_response :success
#   end
  # include Devise::TestHelpers

  #include Devise::Test::IntegrationHelpers
  # setup do
  #   @contract = contracts(:one)
  #   @user = users(:admin)
  #   sign_in(@user)
  #
  #   #@user= users(:admin)
  #   # @request.env["devise.mapping"] = Devise.mappings[:user]
  #   #sign_in @user
  # end

  # test "should get index" do
    # assert false
    # get contracts_url
    # assert_response :succes
    # get 'http://localhost:3000/login' #, :user => {name: @user.name, password: "password"}
    # assert_response :success
    # post 'http://localhost:3000/login', params: { name: "Channing Jacobs", password: "password" }
    # assert_response :success

    # get contracts_url
    # assert_response :success
  # end
  #
  # test "should get new" do
  #   get new_contract_url
  #   assert_response :redirect
  #   post 'login', @user
  #   assert_response :redirect
  # end
  #
  # test "should create contract" do
  #   assert_difference('Contract.count') do
  #   post contracts_url, params: { contract: { expiration_time: @contract.expiration_time, final_payment_method: @contract.final_payment_method, final_price: @contract.final_price, meeting_address_first: @contract.meeting_address_first, meeting_address_second: @contract.meeting_address_second, meeting_time: @contract.meeting_time, status: @contract.status } }
  # end
  #
  #   assert_redirected_to contract_url(Contract.last)
  # end
  #
  # test "should show contract" do
  #   get contract_url(@contract)
  #   assert_response :success
  # end
  #
  # test "should get edit" do
  #   get edit_contract_url(@contract)
  #   assert_response :success
  # end
  #
  # test "should update contract" do
  #   patch contract_url(@contract), params: { contract: { expiration_time: @contract.expiration_time, final_payment_method: @contract.final_payment_method, final_price: @contract.final_price, meeting_address_first: @contract.meeting_address_first, meeting_address_second: @contract.meeting_address_second, meeting_time: @contract.meeting_time, status: @contract.status } }
  #   assert_redirected_to contract_url(@contract)
  # end
  #
  # test "should destroy contract" do
  #   assert_difference('Contract.count', -1) do
  #     delete contract_url(@contract)
  #   end
  #
  #   assert_redirected_to contracts_url
  # end
end
