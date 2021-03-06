module ApplicationHelper
  # Return a title on a per-page basis.
  def title
    base_title = "Sample 420 Application"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end

	def loggedIn
		message = ""
		if session[:user_id]
			"You are successfully logged in"
		else
			message
		end
	end

end

