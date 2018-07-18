require 'test_helper'

class ContractsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @contract = contracts(:one)
  end

  test "should get index" do
    get contracts_url
    assert_response :success
  end

  test "should get new" do
    get new_contract_url
    assert_response :success
  end

  test "should create contract" do
    assert_difference('Contract.count') do
      post contracts_url, params: { contract: { expiration_time: @contract.expiration_time, final_payment_method: @contract.final_payment_method, final_price: @contract.final_price, meeting_address_first: @contract.meeting_address_first, meeting_address_second: @contract.meeting_address_second, meeting_time: @contract.meeting_time, status: @contract.status } }
    end

    assert_redirected_to contract_url(Contract.last)
  end

  test "should show contract" do
    get contract_url(@contract)
    assert_response :success
  end

  test "should get edit" do
    get edit_contract_url(@contract)
    assert_response :success
  end

  test "should update contract" do
    patch contract_url(@contract), params: { contract: { expiration_time: @contract.expiration_time, final_payment_method: @contract.final_payment_method, final_price: @contract.final_price, meeting_address_first: @contract.meeting_address_first, meeting_address_second: @contract.meeting_address_second, meeting_time: @contract.meeting_time, status: @contract.status } }
    assert_redirected_to contract_url(@contract)
  end

  test "should destroy contract" do
    assert_difference('Contract.count', -1) do
      delete contract_url(@contract)
    end

    assert_redirected_to contracts_url
  end
end
