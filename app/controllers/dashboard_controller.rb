class DashboardController < ApplicationController

  def main
    if !current_user.is_a?(GuestUser)
      # Load main view
    else
      flash[:failure] = "You have to sign in to send a message."
      redirect_to new_user_session_url
    end

  end

  def myorder
  end

  def myrequest
  end

  def myoffer
  end

  def account_information
  end

  def messages
  end

  def bookmarks
  end
end
