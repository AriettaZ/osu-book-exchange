class DashboardController < ApplicationController
  # GET routes
  def main
    @user = current_user
  end

  def myorder
    @orders = current_user.contracts.orders
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
    @bookmarks = current_user.bookmarks
  end
end
