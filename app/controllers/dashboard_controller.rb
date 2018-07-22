class DashboardController < ApplicationController

  def main
    if !current_user.is_a?(GuestUser)
      # Load main view
      @user = current_user
    else
      flash[:failure] = "You have to sign in to see your dashboard."
      redirect_to new_user_session_url
    end

  end

  def myorder
    # try to use where later
    @orders = []
    Contract.where(buyer_id: current_user.id).find_each do |contract|
      @orders << contract.order
    end
    # Contract.find_each do |contract|
    #   if contract.buyer_id == current_user.id
    #     @orders << contract.order
    #   end
    # end
  end

  def myrequest
    @requests = []
    Post.where(user_id: 10, type: "request").find_each do |request|
      @requests << request
    end
  end

  def myoffer
  end

  def account_information
  end

  def messages
    current_user.posts.each do |post|
      @messages = post.messages
    end
  end

  def bookmarks
  end
end
