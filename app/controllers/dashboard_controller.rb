# Author: Channing Jacobs
# Created: 7/18
# Edit: 7/22 Gail worked on mycontract and myorder
# Description: Makes actions corresponding to the received request related to dashboard(profile)

class DashboardController < ApplicationController
  before_action :authenticate_user!
  require_relative '../helpers/contact'

  # Below are GET routes for loading user profile data
  def main
    @user = current_user
  end

  def account_information
    @user = current_user
  end

  def mycontract
    activeContracts = Contract.where.not(status: "deleted")
    @contracts = activeContracts.where(buyer_id: current_user.id) + activeContracts.where(seller_id: current_user.id)
  end

  # Set up orders for display to user
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

  # Get all orders from this user
  def myrequest
    @requests = current_user.posts.where(post_type: "request")
  end

  # Get all requests from this user
  def myoffer
    @offers = current_user.posts.where(post_type: "offer")
  end

  def update_account_info
    # edit route
    redirect_to edit_user_registration_url
  end

  # Author: Mike
  # Created: 7/19
  # Description: GET route for retrieving conversations
  def contacts
    @contacts = []

    # Search current_user as sender
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

      # If haven't added partner to list contact, then create and append the new contact
      unless has_contact then
        new_contact = Contact.new(message.receiver_id, User.find_by_id(message.receiver_id) , message.post_id, message.created_at)
        new_contact.post = Post.find_by_id(message.post_id)
        new_contact.book = Book.find_by_id(new_contact.post.book_id)
        @contacts.append(new_contact)
      end
    end

    # Search current_user as receiver
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

      # If haven't added partner to list contact, then create and append the new contact
      unless has_contact then
        new_contact = Contact.new(message.sender_id, User.find_by_id(message.sender_id) , message.post_id, message.created_at)
        new_contact.post = Post.find_by_id(message.post_id)
        new_contact.book = Book.find_by_id(new_contact.post.book_id)
        @contacts.append(new_contact)
      end
    end

    # Sort the conversation by message time
    @contacts.sort! do |b, a|
      a.latest_message_time <=> b.latest_message_time
    end
    @talk_to = User.new
  end


  # Author: Mike
  # Created: 7/19
  # Description: Retrive all the message about a conversation in the message database
  def messages
    @messages = []

    # If has parameter last_msg_time, then use the method append_messages
    if params[:last_msg_time] && params[:last_msg_time]!="undefined" then
      append_messages
      return
    else
      # Search Message for current_user as sender
      Message.where(sender_id: current_user.id, receiver_id: params[:talk_to]).find_each do |message|
        @messages.append(message)
      end
      # Search Message for current_user as receiver
      Message.where(sender_id: params[:talk_to], receiver_id: current_user.id).find_each do |message|
        @messages.append(message)
      end
      # Sort the result messages by time
      @messages.sort_by! do |message|
        message.created_at
      end
      @talk_to_name = User.find_by_id(params[:talk_to]).name
      @message = Message.new
    end

  end

  # Author: Mike
  # Created: 7/19
  # Description: POST route to create a new message
  def create_message
    @message = Message.new(content: params[:content],
                           sender_id: current_user.id,
                           post_id: params[:post_id].to_i,
                           receiver_id: params[:talk_to].to_i
              )
    if @message.save
      flash[:success] = "Message sent for post id: " + params[:post_id].to_s
      if params[:last_msg_time] && params[:last_msg_time]!="undefined" then
        append_messages
      else
        redirect_to profile_messages_path(talk_to: params[:talk_to], post_id: params[:post_id])
      end
    else
      @message.errors.each do |type, text|
        flash.now[:success] = type.to_s.capitalize + " " + text
      end
      redirect_to profile_messages_path(talk_to: params[:talk_to], post_id: params[:post_id])
    end

  end

  # Author: Mike
  # Created: 7/19
  # Description: Retrive messages since last_msg_time
  def append_messages
      @appended_messages = []

      # Retrive messages for current_user as sender
      Message.where(created_at: params[:last_msg_time]..Time.now, sender_id: current_user.id, receiver_id: params[:talk_to]).find_each do |message|
        @appended_messages.append(message)
      end

      # Retrive messages for current_user as receiver
      Message.where(created_at: params[:last_msg_time]..Time.now, sender_id: params[:talk_to], receiver_id: current_user.id).find_each do |message|
        @appended_messages.append(message)
      end

      # Sort the messages by time
      @appended_messages.sort_by! do |message|
        message.created_at
      end

      # Remove the first one for duplicates
      @appended_messages.shift

      # Render the partial html for Ajax call
      render partial: "appended_messages"

  end

  def bookmarks
    @bookmarks = current_user.bookmarks

    # sorting is handled by jquery table plugin
    # code left in case of plugin removal
    # fav_arr = []
    # unfav_arr = []
    # @bookmarks.each do |bookmark|
    #   if bookmark.favorite
    #     fav_arr.append bookmark
    #   else
    #     unfav_arr.append bookmark
    #   end
    # end
    #     fav_arr.sort_by! {|bm| bm.updated_at}
    #     fav_arr.reverse!
    #     unfav_arr.sort_by! {|bm| bm.updated_at}
    #     unfav_arr.reverse!
    #     @bookmarks  = fav_arr + unfav_arr
  end
end
