# Create by Channing Jacobs, July 21st 2018
# Messages are created by clicking message on a post
# Sellers can see all messages for a post, organized by buyer
# Buyers can only see messages for posts where they're messaging sellers
class MessagesController < ApplicationController
  before_action :authenticate_user!

  def list
    
  end

  def show
    # Show may not be used
    @message = Message.find_by(params[:id])
  end

  def new
    if !current_user.is_a?(GuestUser)
      @message = Message.new
      #flash[:success] = params
    else
      flash[:failure] = "You have to sign in to send a message."
      redirect_to new_user_session_url
    end
  end

  def create
    # if !Post.find_by_id(params[:post_id])
    #   render "messages/new" and return
    # end

    @message = Message.new(content: params[:message][:content],
                           sender_id: current_user.id,
                           post_id: Post.find(params[:post_id]).id,
                           receiver_id: Post.find(params[:post_id]).user.id
              )
    # flash.now[:success] = @message.inspect
    if @message.save
      flash[:success] = "Message sent for post id: " + params[:post_id].to_s
      redirect_to posts_url
    else
      # Show saving errors.
      @message.errors.each do |type, text|
        flash.now[:success] = type.to_s.capitalize + " " + text
      end
      render "messages/new"
    end

  end

  private
  # def message_param
  #   params.require(:message).permit(:content)
  # end


end
