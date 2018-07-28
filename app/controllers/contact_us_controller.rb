# Author: Mike
# Created at: 7/22
# Edit: N/A
# Description: This controller execute the only contact_us routes for contact_us page.

class ContactUsController < ApplicationController
	def contact_us

		# If guest, then render guest page
		if current_user.is_a?(GuestUser) then
			render "pages/guest_contact"
			return
		end

		# Send messae to administrater 
		@message = Message.new(content: params[:content],
                           sender_id: current_user.id,
                           # receiver_id: Post.find(params[:post_id]).user.id
                           post_id: params[:talk_to]||1,
                           receiver_id: 13
              )

		# If message correctly sent, redirect to profile-messages routes
	    if @message.save
			redirect_to profile_messages_path(talk_to: 13, post_id: params[:talk_to] || 1)
	    else
	     	redirect_to root_path
	    end
	end
end
