module ApplicationHelper

	def messages_for(object = nil)
		render :partial => 'shared/messages', :locals => {:obj => object}
	end

end
