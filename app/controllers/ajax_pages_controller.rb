# Created by Channing Jacobs 7/23
# Edit: 7/24 Gail added contract and order list
# This controller responds to ajax requests to load partials
class AjaxPagesController < ApplicationController
  respond_to :html, :js
  before_action :offer_setup, only: [:a_offer, :p_offer, :c_offer, :d_offer]
  before_action :request_setup, only: [:a_request, :p_request, :c_request, :d_request]
  before_action :order_setup, only: [:a_order, :p_order, :cl_order, :ca_order]
  before_action :contract_setup, only: [:u_contract, :w_contract, :c_contract, :d_contract]

  # offer tables for dashboard
  def a_offer
    render partial: "offer", locals: {type: "active", table_name: "a-off-table"}
  end
  def p_offer
    render partial: "offer", locals: {type: "pending", table_name: "p-off-table"}
  end
  def c_offer
    render partial: "offer", locals: {type: "closed", table_name: "c-off-table"}
  end
  def d_offer
    render partial: "offer", locals: {type: "draft", table_name: "d-off-table"}
  end

  # request tables for dashboard
  def a_request
    render partial: "request", locals: {type: "active", table_name: "a-req-table"}
  end
  def p_request
    render partial: "request", locals: {type: "pending", table_name: "p-req-table"}
  end
  def c_request
    render partial: "request", locals: {type: "closed", table_name: "c-req-table"}
  end
  def d_request
    render partial: "request", locals: {type: "draft", table_name: "d-req-table"}
  end

  # order lists for dashboard
  def a_order
    render partial: "order", locals: {status: "active", list_name: "a-ord-list"}
  end
  def p_order
    render partial: "order", locals: {status: "problematic", list_name: "p-ord-list"}
  end
  def cl_order
    render partial: "order", locals: {status: "completed", list_name: "cl-ord-list"}
  end
  def ca_order
    render partial: "order", locals: {status: "canceled", list_name: "ca-ord-list"}
  end

  # contract lists for dashboard
  def u_contract
    render partial: "contract", locals: {status: "unsigned", list_name: "u-con-list"}
  end
  def w_contract
    render partial: "contract", locals: {status: "waiting", list_name: "w-con-list"}
  end
  def c_contract
    render partial: "contract", locals: {status: "confirmed", list_name: "c-con-list"}
  end
  def d_contract
    render partial: "contract", locals: {status: "declined", list_name: "d-con-list"}
  end

  private
  # setups for request and offer tables
  def offer_setup
    @offers = current_user.posts.where(post_type: "offer")
  end
  def request_setup
    @requests = current_user.posts.where(post_type: "request")
  end

  # setups for order and contract lsits
  def order_setup
    contracts = Contract.where(buyer_id: current_user.id) + Contract.where(seller_id: current_user.id)
    @orders = Order.where(contract_id: contracts.first.id)
    contracts[1..contracts.length].each do |contract|
      @orders += Order.where(contract_id: contract.id)
    end
  end

  def contract_setup
    @contracts = Contract.where(buyer_id: current_user.id) + Contract.where(seller_id: current_user.id)
  end
end
