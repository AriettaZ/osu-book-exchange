require "application_system_test_case"

class ContractsTest < ApplicationSystemTestCase
  setup do
    @contract = contracts(:one)
  end

  test "visiting the index" do
    visit contracts_url
    assert_selector "h1", text: "Contracts"
  end

  test "creating a Contract" do
    visit contracts_url
    click_on "New Contract"

    fill_in "Expiration Time", with: @contract.expiration_time
    fill_in "Final Method", with: @contract.final_method
    fill_in "Final Price", with: @contract.final_price
    fill_in "Meeting Address First", with: @contract.meeting_address_first
    fill_in "Meeting Address Second", with: @contract.meeting_address_second
    fill_in "Meeting Time", with: @contract.meeting_time
    fill_in "Status", with: @contract.status
    click_on "Create Contract"

    assert_text "Contract was successfully created"
    click_on "Back"
  end

  test "updating a Contract" do
    visit contracts_url
    click_on "Edit", match: :first

    fill_in "Expiration Time", with: @contract.expiration_time
    fill_in "Final Method", with: @contract.final_method
    fill_in "Final Price", with: @contract.final_price
    fill_in "Meeting Address First", with: @contract.meeting_address_first
    fill_in "Meeting Address Second", with: @contract.meeting_address_second
    fill_in "Meeting Time", with: @contract.meeting_time
    fill_in "Status", with: @contract.status
    click_on "Update Contract"

    assert_text "Contract was successfully updated"
    click_on "Back"
  end

  test "destroying a Contract" do
    visit contracts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Contract was successfully destroyed"
  end
end
