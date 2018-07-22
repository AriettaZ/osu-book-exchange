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
    @orders = Contract.find_by(buyer_id: 3)
  end

  def myrequest
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
