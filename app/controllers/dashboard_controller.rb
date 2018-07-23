class DashboardController < ApplicationController
  def myorder
  end

  def myrequest
  end

  def myoffer
  end

  def account_information
  end

  def contacts
    contacts_id = {}
    Message.where(sender_id: current_user.id).find_each do |message|
      unless contacts_id.key?(message.receiver_id) then
        unless contacts_id[message.receiver_id]==message.post_id then
          contacts_id[message.receiver_id]=message.post_id
        end
      end
    end

    Message.where(receiver_id: current_user.id).find_each do |message|
      unless contacts_id.key?(message.sender_id) then
        unless contacts_id[message.sender_id]==message.post_id then
          contacts_id[message.sender_id]=message.post_id
        end
      end
    end

    @contacts = {}
    contacts_id.each do |user_id, post_id|
      @contacts[User.find_by_id(user_id)]=Post.find_by_id(post_id)
    end
    @talk_to = User.new
  end

  def messages

    if params[:last_msg_time] then
      append_messages
    else
      # @messages = Message.where(sender_id: 2, receiver_id: 12)
      @messages = []
      Message.where(sender_id: current_user.id, receiver_id: params[:talk_to]).find_each do |message|
        @messages.append(message)
      end
      Message.where(sender_id: params[:talk_to], receiver_id: current_user.id).find_each do |message|
        @messages.append(message)
      end
      @messages.sort_by! do |message|
        message.created_at
      end
      # @msg = params
      @talk_to_name = User.find_by_id(params[:talk_to]).name
      @message = Message.new
    end

  end

  def create_message
    # if !Post.find_by_id(params[:post_id])
    #   render "messages/new" and return
    # end

    # For Previous Refresh Use
    # @message = Message.new(content: params[:message][:content],
    #                        sender_id: current_user.id,
    #                        # receiver_id: Post.find(params[:post_id]).user.id
    #                        post_id: params[:post_id].to_i,
    #                        receiver_id: params[:talk_to]
    #           )

    @message = Message.new(content: params[:content],
                           sender_id: current_user.id,
                           # receiver_id: Post.find(params[:post_id]).user.id
                           post_id: params[:post_id].to_i,
                           receiver_id: params[:talk_to].to_i
              )
    # flash.now[:success] = @message.inspect
    if @message.save
      flash[:success] = "Message sent for post id: " + params[:post_id].to_s
      # redirect_to dashboard_messages_path(talk_to: params[:talk_to], post_id: params[:post_id])
      append_messages
    else
      # Show saving errors.
      @message.errors.each do |type, text|
        flash.now[:success] = type.to_s.capitalize + " " + text
      end
      redirect_to dashboard_messages_path(talk_to: params[:talk_to], post_id: params[:post_id])
    end

  end

  def append_messages
    @appended_messages = []
    Message.where(created_at: params[:last_msg_time]..Time.now, sender_id: current_user.id, receiver_id: params[:talk_to]).find_each do |message|
      @appended_messages.append(message)
    end
    Message.where(created_at: params[:last_msg_time]..Time.now, sender_id: params[:talk_to], receiver_id: current_user.id).find_each do |message|
      @appended_messages.append(message)
    end

    @appended_messages.sort_by! do |message|
      message.created_at
    end

    @appended_messages.shift

    render partial: "appended_messages"

  end

  def bookmarks
  end
end
