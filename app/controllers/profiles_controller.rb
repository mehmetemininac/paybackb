class ProfilesController < ApplicationController
	before_filter :authenticate_user!

	def my_profile
	end

end
