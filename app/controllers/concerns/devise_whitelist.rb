module DeviseWhitelist
  extend ActiveSupport::Concern
  included do
    before_action :configuration_permitted_parameters, if: :devise_controller?
  end
  def configuration_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,keys:[:name])
    devise_parameter_sanitizer.permit(:account_update,keys:[:name])
    devise_parameter_sanitizer.permit(:sign_up,keys:[:major])
    devise_parameter_sanitizer.permit(:account_update,keys:[:major])
  end
end
