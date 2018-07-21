# Create by Channing Jacobs, July 21st 2018
# Messages are created by clicking message on a post
# Sellers can see all messages for a post, organized by buyer
# Buyers can only see messages for posts where they're messaging sellers
class MessagesController < ApplicationController
  #before_action :authenticate_user!

  def list

  end

  def show
    # Show may not be used
    @message = Message.find_by(params[:id])
  end

  def new
    @message = Message.new
    if current_user.is_a?(GuestUser)
      @message = Message.new
      flash.now[:success] = "Message sent."
    else
      flash[:failure] = "You have to sign in to send a message."
      redirect_to root_url
    end
  end

  def create
    @message = Message.new(message_param)
    #@message.
    #@message.post_id
    #@message.receiver_id

  end

  private
  def message_param
    params.require(:message).permit(:content)
  end


end
