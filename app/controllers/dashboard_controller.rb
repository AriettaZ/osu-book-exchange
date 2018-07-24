class DashboardController < ApplicationController
  before_action :authenticate_user!
  require_relative '../helpers/contact'

  # GET routes
  def main
    @user = current_user
  end
  def account_information
    @user = current_user
  end
  def mycontract
    @contracts = Contract.where(buyer_id: current_user.id) + Contract.where(seller_id: current_user.id)
  end

  def myorder
    @contracts = Contract.where(buyer_id: current_user.id) + Contract.where(seller_id: current_user.id)
    if @contracts.empty?
      @orders = []
    else
      @orders = Order.where(contract_id: @contracts.first.id)
      @contracts[1..@contracts.length].each do |contract|
        @orders += Order.where(contract_id: contract.id)
      end
    end
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

  def contacts
    @contacts = []


    Message.where(sender_id: current_user.id).find_each do |message|
      has_contact = false
      @contacts.each do |contact|
        # If find partner and post match
        if contact.partner_id==message.receiver_id && contact.post_id==message.post_id then
          # If message time earlier than this message time
          if (contact.latest_message_time<=>message.created_at)<0 then
            contact.latest_message_time = message.created_at
          end

          has_contact = true
        end
      end

      unless has_contact then
        new_contact = Contact.new(message.receiver_id, User.find_by_id(message.receiver_id) , message.post_id, message.created_at)
        new_contact.post = Post.find_by_id(message.post_id)
        new_contact.book = Book.find_by_id(new_contact.post.book_id)
        @contacts.append(new_contact)

      end
    end


    Message.where(receiver_id: current_user.id).find_each do |message|

      has_contact = false

      @contacts.each do |contact|
        # If find partner and post match
        if contact.partner_id==message.sender_id && contact.post_id==message.post_id then
          # If message time earlier than this message time
          if (contact.latest_message_time<=>message.created_at)<0 then
            contact.latest_message_time = message.created_at
          end

          has_contact = true
        end
      end

      unless has_contact then
        new_contact = Contact.new(message.sender_id, User.find_by_id(message.sender_id) , message.post_id, message.created_at)
        new_contact.post = Post.find_by_id(message.post_id)
        new_contact.book = Book.find_by_id(new_contact.post.book_id)
        @contacts.append(new_contact)
      end
    end


    @contacts.sort! do |b, a|
      a.latest_message_time <=> b.latest_message_time
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
      # redirect_to profile_messages_path(talk_to: params[:talk_to], post_id: params[:post_id])
      append_messages
    else
      # Show saving errors.
      @message.errors.each do |type, text|
        flash.now[:success] = type.to_s.capitalize + " " + text
      end
      redirect_to profile_messages_path(talk_to: params[:talk_to], post_id: params[:post_id])
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
    @bookmarks = current_user.bookmarks
  end
end
