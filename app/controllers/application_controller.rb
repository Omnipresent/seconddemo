# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  before_filter :check_authentication, :except => [:index, :login]
  
	def check_authentication	
				if session != nil && session[:user_id] == nil
					redirect_to :controller => 'admin', :action => "login"
				end
    end
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
end
