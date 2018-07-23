class DashboardController < ApplicationController
  # GET routes
  def main
    @user = current_user
  end

  def mycontract
    @contracts = Contract.where(buyer_id: current_user.id) + Contract.where(seller_id: current_user.id)
  end

  def myorder
    @contracts = Contract.where(buyer_id: current_user.id) + Contract.where(seller_id: current_user.id)
    @orders = Order.where(contract_id: @contracts.first.id)
    @contracts[1..@contracts.length].each do |contract|
      @orders += Order.where(contract_id: contract.id)
    end
  end

  def myrequest
    @requests = current_user.posts.where(post_type: "request")
  end

  def myoffer
    @offers = current_user.posts.where(post_type: "offer")
  end

  def update_account_info
    # edit route
    redirect_to edit_user_registration_url
  end

  # Moving to message controller?
  # def messages
  # end

  def bookmarks
  end
end
