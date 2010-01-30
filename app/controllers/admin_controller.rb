class AdminController < ApplicationController
	layout "application", :except => [:login, :select_store]
  def login
    session[:user_id] = nil
    if request.post?
      if @user = User.authenticate(params[:user][:userid],  params[:user][:password])
        session[:user_id] = @user.id
				if @user.stores.length > 0
	        redirect_to(:controller => "admin", :action => "select_store")
	      else
	      	redirect_to(:controller => "pages", :action => "mainpage")
	      end
    	else
        flash.now[:notice] = "Invalid user/password combination"
      end
	   end
  end

	def select_store
	  @user = User.find(session[:user_id])	
	  if request.post?
	  	@user = User.find(session[:user_id])
	  	if @user.stores.find_by_store_id(params[:selected_store][:id])
	  		session[:store_id] = params[:selected_store][:id]
				session[:store_name] = @user.stores.find_by_store_id(params[:selected_store][:id]).store_name
	  		redirect_to(:controller => "pages", :action =>"mainpage")
  		else
  			redirect_to(:controller => "admin", :action => "login")
  		end
	  end	
	end


  def logout
		session = nil
  	redirect_to(:controller => "pages", :action => "index")
  end

	def store
		
	end

end
