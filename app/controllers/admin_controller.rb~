class AdminController < ApplicationController
	layout "application", :except => [:login, :select_store, :admin_main, :changepwd]
	
	def admin_main
				
	end
	
	def changepwd
		@user = User.find(session[:user_id])
		if request.post?
		  @user = User.find(session[:user_id])
			if @user.update_attributes(:password => params[:user][:password], :user_status=>"A")
				flash[:changepwd] = "Password changed successfully"
				redirect_to :controller => "pages", :action => "mainpage"
			end
		end
	end
	
	
  def login
    session[:user_id] = nil
    if request.post?
      if @user = User.authenticate(params[:user][:userid],  params[:user][:password]) and @user.user_status != "D"
        session[:user_id] = @user.id
        if @user.user_status == "N"
        	redirect_to(:controller => "admin", :action => "changepwd")
				elsif @user.stores.find(:all, :conditions => ["store_status = ?", "A"]).length > 0
	        redirect_to(:controller => "admin", :action => "select_store")
	      else
	      	redirect_to(:controller => "pages", :action => "mainpage")
	      end
    	elsif @user !=nil and @user.user_status == "D"
        flash.now[:invalid] = "User Deleted"
      else
      	flash.now[:invalid] = "Invalid user/password combination"
      end
	   end
  end

	def select_store
	  @user = User.find(session[:user_id])	
	  if request.post?
	  	@user = User.find(session[:user_id])
	  	if @user.stores.find_by_id(params[:selected_store][:id])
	  		session[:store_id] = params[:selected_store][:id]
				session[:store_name] = @user.stores.find_by_id(params[:selected_store][:id]).store_name
	  		redirect_to(:controller => "pages", :action =>"mainpage")
  		else
  			redirect_to(:controller => "admin", :action => "login")
  		end
	  end	
	end


  def logout
		session = nil
  	redirect_to(:controller => "admin", :action => "login")
  end

	def store
		
	end

end
