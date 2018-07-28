class ApplicationController < ActionController::Base
  devise_parameter_sanitizer.permit(:sign_up,keys:[:name])
  devise_parameter_sanitizer.permit(:account_update,keys:[:name])
  devise_parameter_sanitizer.permit(:sign_up,keys:[:major])
  devise_parameter_sanitizer.permit(:account_update,keys:[:major])
  def current_user
    super || guest_user
  end
  def guest_user
    guest=GuestUser.new
    guest.name = "Guest"
    guest.first_name="Guest"
    guest.last_name="User"
    guest.email="Guest@example.com"
    guest.roles=[:guest]
    guest
  end
end
