class Contact

  def initialize(partnerId, partner, postId, latest_message_time)
  	@partner_id = partnerId
  	@partner = partner
  	@post_id = postId
  	@post = post
  	@book = nil
  	@latest_message_time = latest_message_time
  end

  attr_accessor :partner_id
  attr_accessor :partner
  attr_accessor :post_id
  attr_accessor :book
  attr_accessor :post
  attr_accessor :latest_message_time

end