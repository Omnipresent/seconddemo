class StoresController < ApplicationController
	layout "application", :except => [:index, :show, :edit, :new]
	
  def register
  end

  def index
    @stores = Store.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  def show
    @store = Store.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @store = Store.new
    @user = User.find(session[:user_id])
    @user_full_name = @user.user_first_name + " " + @user.user_last_name
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @store = Store.find(params[:id])
    #@stores = Store.all
  end

  # POST /users
  # POST /users.xml
  def create
    #@user = User.new(params[:user])

    respond_to do |format|
      if (@store = Store.create(params[:store]))
        flash[:notice] = 'Store was successfully created.'
        format.html { redirect_to(@store) }
        format.xml  { render :xml => @store, :status => :created, :location => @store }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @store.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @store = Store.find(params[:id])

    respond_to do |format|
      if @store.update_attributes(params[:store])
        #@user.stores.each {|u| @iz = Userization.find_by_user_id_and_store_id(@user.id, u.store_id); @iz.destroy}
        #params[:stores].each{|s| Userization.create(:user_id => @user.id, :store_id => s)}
        flash[:notice] = 'Store was successfully updated.'
        format.html { redirect_to(@store) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @store.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @store = Store.find(params[:id])
    if @store.store_status == "A"
	    @store.update_attributes(:store_status=>"D")
	  elsif @store.store_status == "D"
		  @store.update_attributes(:store_status=>"A")
		else
			@store.update_attributes(:store_status=>"D")
	  end

    respond_to do |format|
      format.html { redirect_to(stores_url) }
      format.xml  { head :ok }
    end
  end
end
