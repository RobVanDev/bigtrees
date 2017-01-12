module UserHelper
	def sign_in(user)
		session_token = user.session_token
		cookies.permanent[:session_token] = session_token
		self.current_user = user
	end
	
	def sign_out
		cookies.delete(:session_token)
		self.current_user = nil
  end
	
    def current_user=(user)
		@current_user = user
    end
	
	def current_user
		session_token = cookies[:session_token]
		@current_user ||= User.where(session_token: session_token)
						
    end
	
	def signed_in?
		if current_user.nil? or current_user.empty?
			logger.debug "NO USER"
			return false
		else
			logger.debug "CURRENT_USER"
			return true
		end

	end
end