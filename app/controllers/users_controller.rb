class UsersController < ApplicationController
	layout "application"
	
  def register
  end

  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  def show
    @user = User.find(params[:id])
		@stores = Store.all
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new
    @user.stores.build
		@stores = Store.all
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
    @stores = Store.all
  end

  # POST /users
  # POST /users.xml
  def create
    #@user = User.new(params[:user])

    respond_to do |format|
      if (@user = User.create(params[:user]))
        params[:stores].each{|s| Userization.create(:user_id => @user.id, :store_id => s)}
        flash[:notice] = 'User was successfully created.'
        format.html { redirect_to(@user) }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        @user.stores.each {|u| @iz = Userization.find_by_user_id_and_store_id(@user.id, u.id); @iz.destroy}
        params[:stores].each{|s| Userization.create(:user_id => @user.id, :store_id => s)}
        flash[:notice] = 'User was successfully updated.'
        format.html { redirect_to(@user) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    #@user.stores.each {|u| @iz = Userization.find_by_user_id_and_store_id(@user.id, u.store_id); @iz.destroy}
    if @user.user_status == "A"
	    @user.update_attributes(:user_status=>"D")
	  elsif @user.user_status == "D"
		  @user.update_attributes(:user_status=>"A")
		else
			@user.update_attributes(:user_status=>"D")
	  end

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
end
