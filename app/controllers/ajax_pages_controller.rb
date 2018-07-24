# Created by Channing Jacobs 7/23
# This controller responds to ajax requests to load partials
class AjaxPagesController < ApplicationController
  respond_to :html, :js
  before_action :offer_setup, only: [:a_offer, :p_offer, :c_offer, :d_offer]
  before_action :request_setup, only: [:a_request, :p_request, :c_request, :d_request]

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

  private
  # setups for request and offer tables
  def offer_setup
    @offers = current_user.posts.where(post_type: "offer")
  end
  def request_setup
    @requests = current_user.posts.where(post_type: "request")
  end
end
