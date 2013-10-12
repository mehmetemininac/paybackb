class ApplicationController < ActionController::Base
  before_filter :configure_permitted_parameters, if: :devise_controller?

  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource_or_scope)
  	accounting_records_path
  end

  def after_sign_out_path_for(resource_or_scope)
  	logged_out_path
  end

private
	def configure_permitted_parameters
		devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:user_name, :email, :password, :password_confirmation)}
	end
end
