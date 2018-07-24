# Created by Channing Jacobs 7/23
# This controller responds to ajax requests to load partials
class AjaxPagesController < ApplicationController
  respond_to :html, :js

  def a_offer
    @offers = current_user.posts.where(post_type: "offer")
    render partial: "a_offer"
  end

  def p_offer
    @offers = current_user.posts.where(post_type: "offer")
    render partial: "p_offer"
  end

  def c_offer
    @offers = current_user.posts.where(post_type: "offer")
    render partial: "c_offer"
  end

  def d_offer
    @offers = current_user.posts.where(post_type: "offer")
    render partial: "d_offer"
  end
end
