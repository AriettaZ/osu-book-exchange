class ContactUsController < ApplicationController
	def contact_us

		if current_user.is_a?(GuestUser) then
			render "pages/guest_contact"
			return
		end

		@message = Message.new(content: params[:content],
                           sender_id: current_user.id,
                           # receiver_id: Post.find(params[:post_id]).user.id
                           post_id: 1,
                           receiver_id: 13
              )

	    # flash.now[:success] = @message.inspect
	    if @message.save
	      # flash[:success] = "Message sent for post id: " + params[:post_id].to_s
	      # redirect_to dashboard_messages_path(talk_to: params[:talk_to], post_id: params[:post_id])
	      redirect_to dashboard_messages_path(talk_to: 13, post_id: 0)
	    else
	      # Show saving errors.
	      # @message.errors.each do |type, text|
	      #   flash.now[:success] = type.to_s.capitalize + " " + text
	      # end
	      redirect_to new_user_session_path
	    end
	end
end
