# encoding: utf-8
class OmniauthCallbacksController < Devise::OmniauthCallbacksController
	def all_providers
		user = User.from_omniauth(request.env["omniauth.auth"])
		if user.persisted?
			flash[:success] = "Sisteme Giriş Yaptınız"
			sign_in_and_redirect user
		else
			session["devise.user_attributes"] = user.attributes
			redirect_to new_user_registration_path
		end
	end
	alias_method :facebook, :all_providers
	alias_method :twitter, :all_providers
end
