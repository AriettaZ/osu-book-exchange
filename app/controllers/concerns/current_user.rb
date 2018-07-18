module CurrentUser
  extend ActiveSupport::Concern
  def current_user
    super || OpenStruct.new(new: "Guest User", first_name:"Guest",last_name:"User",email:"guest@example.com")
  end
end
