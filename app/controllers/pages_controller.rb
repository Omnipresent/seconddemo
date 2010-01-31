class PagesController < ApplicationController
	layout "application", :except => [:index, :mainpage]
	
	
	def edit_product			
#		@products = Product.new
		@products = Product.find_by_id(params[:id])
		if request.post?
			if (Product.update(params[:id], params[:product]) != nil)
		  	redirect_to :controller => 'pages', :action => 'product' 
		  end
		end
	end
	
	def product
		@products = Product.new(params[:product])

			@prods = Product.find(:all)
			flash[:product] = "Currently there are #{@prods.size} products"
		if request.post?
			if @products.save
				@prods = Product.find(:all)
				flash[:product] = "Product #{params[:pname]} saved successfully"
			end
		end
	end
	
	def physician
		
	end
	
	def mainpage
		
	end
	
  def about
  end
  
  def reports
  end

  
  def patient
  	
  end
  
  def search
		if params[:type] == "Patient"
			if params[:search] != nil and params[:search].length >0
				@customer = Customer.all(:conditions => ["UPPER(firstname) LIKE ?", "%#{params[:search]}%".upcase], :include => :contact)
			elsif params[:phone] and params[:phone].length >0
				@customer = Customer.all(:conditions => ["contacts.hphone LIKE ?", "%#{params[:phone]}%"], :include => :contact)
			end
		elsif params[:type] == "Physician"
			if params[:search] != nil and params[:search].length >0
				@customer = Customer.find(:all, :conditions => ['"firstname" LIKE 	?', "%#{params[:search]}%"])	
			elsif params[:phone] and params[:phone].length >0
				@customer = Customer.find(:all, :conditions => ['"phoneNumber" LIKE 	?', "%#{params[:phone]}%"])	
			end
		else
			@customer = []
		end
		if @customer == nil
			@customer = Customer.all(:include => :contact)
		end
		if params[:type] == nil
			params[:type] = "Patient"
		#	flash[:search] = "Total #{@customer.size} #{params[:type]}" unless @customer == nil
		else
			flash[:search] = "Found #{@customer.size} #{params[:type]}" unless @customer == nil
		end
		
		@type = params[:type]
 
		if params[:type] == "Physician"
			flash[:search] = "Physician search not implemented yet"
			@customer = []
		end
	end
 
  def contactus
  end
  def index
  	redirect_to :controller => 'admin', :action => 'login' 
  end
  
  
  
  #edit
  def editcustomer
@custid = params[:id]
 if params[:commit] == "Update Customer Information"
  
  @varinsert = {:firstname=>params[:firstname], :lastname=>params[:lastname], :dob=>params[:dob],:dln=>params[:dln],:sex=>params[:sex], :referral=>params[:referral], :reffredby=>params[:reffredby],:notes=>params[:notes],:statemmp=>params[:statemmp],:recom=>params[:recom], :countyid=>params[:countyid], :suffix=>params[:suffix], :dlnstate=>params[:dlnstate], :dlnexpiry=>params[:dlnexp]}
  @cust = Customer.update(@custid, @varinsert)
  @varinsert = {:line1=>params[:line1] , :county=>params[:county], :line2=>params[:line2], :city=>params[:city],:state=>params[:state], :zip=>params[:zip]}
  @cust = Address.update(@custid, @varinsert)
  @varinsert = {:hphone=>params[:hphone] , :mphone=>params[:mphone], :cemail=>params[:cemail]}
  @cust = Contact.update(@custid, @varinsert)
  flash[:edit_customer]= "Customer Information Updated"
  redirect_to :controller => 'pages', :action => 'search' 
  return
else 
 flash[:notice]= params[:commit]
@cond = "id = " + params[:id]
@customer = Customer.find(:all, :conditions => [@cond], :include => :contact, :include => :address )
params[:firstname] = @customer.first.firstname
params[:lastname] = @customer.first.lastname
params[:dob] = @customer.first.dob
params[:dln] = @customer.first.dln
params[:sex] = @customer.first.sex
params[:referral] = @customer.first.referral
params[:reffredby] = @customer.first.reffredby
params[:notes] = @customer.first.notes
params[:statemmp] = @customer.first.statemmp
params[:recom] = @customer.first.recom
params[:countyid] = @customer.first.countyid
params[:suffix] = @customer.first.suffix
params[:dlnstate] = @customer.first.dlnstate
params[:dlnexp] = @customer.first.dlnexpiry
params[:line1]  = @customer.first.address.line1
params[:county] = @customer.first.address.county
params[:line2] = @customer.first.address.line2
params[:city] = @customer.first.address.city
params[:state] = @customer.first.address.state
params[:zip] = @customer.first.address.zip
params[:hphone] = @customer.first.contact.hphone
params[:mphone] = @customer.first.contact.mphone
params[:cemail] = @customer.first.contact.cemail
params[:provider] = @customer.first.contact.provider
end
end
  
  
  def customer
  @phys = Physician.find(:all) #gets all physicians
   if request.post?

  if params[:commit] == "save"
  sql = ActiveRecord::Base.connection();
  @sqlstmmt3 = "INSERT INTO physicians (pname,degree,pgroup,plicnum,licexpdate) VALUES ('" + params[:pname1] + "', '"+ params[:pdegree1] + "', '"+ params[:pgroup1] + "', '"+ params[:plicnum1] + "', '"+ params[:licexpdate1] +"')"
  sql.begin_db_transaction
  @@sides =  params[:firstName]
  @physid= sql.insert(@sqlstmmt3)
    session[:physid]  = @physid
	 flash[:customerpage] = "Added Physician" 
	   @phys = Physician.find(:all) #gets all physicians

  sql.commit_db_transaction
  end
    if params[:commit] == "Add Customer Information"
		 @sqlstmmt = "INSERT INTO customers (firstname, lastname, dob, dln, sex, referral, reffredby, notes, statemmp, recom, countyid, suffix, dlnstate, dlnexpiry) VALUES ('"+params[:firstname] + 
		 "', '"+ params[:lastname] + "', '"+params[:dob]+ "', '" + params[:dln] + "', '"  +           params[:sex] + "', '"+ params[:referral] +"', '"+ params[:reffredby] + 
		 "', '"+ params[:notes] + "', '"+ params[:statemmp] + "', '"+ params[:recom] + "', '"+ params[:countyid]+ "', '"+ params[:suffix]+ "', '"+ params[:dlnstate] + "', '"+ params[:dlnexp]  +"')"
		 #sql staement to insert into address table
		 @sqlstmmt1 = "INSERT INTO addresses (\"line1\", \"line2\", city, state, zip, county) VALUES ('" + params[:line1] + "', '"+ params[:line2] + "', '"+params[:city]+ "', '" + params[:state] + "', '" + params[:zip]+ "', '" + params[:county]+"')"
		 sql = ActiveRecord::Base.connection();
		 sql.begin_db_transaction
		 @@sides =  params[:firstName]
		 @id1 = sql.insert(@sqlstmmt)
		 session[:customer_id] = @id1
		 sql.commit_db_transaction
		 sql.begin_db_transaction
		 @id2 = sql.insert(@sqlstmmt1)
		 sql.commit_db_transaction
		 @varsms = "no"
		 @varmail = "no"
		 @varemail = "no"
      if params[:sms] == "yes"
		 @varsms = "yes"
      end
     if params[:mail] == "yes"
         @varmail = "yes"
     end
     if params[:email] == "yes"
		 @varemail = "yes"
     end
  # sql statement to insert into contact links table
		@sqlcontact =  "INSERT INTO contacts (id,\"cid\", \"hphone\", mphone, provider, cemail, email, sms , mail) VALUES ('"+@id1+"','" + @id1  + "', '"+ params[:hphone] + "', '"+params[:mphone]+ "', '" + params[:provider] + "', '" + params[:cemail]+ "', '" +      @varemail+ "', '"+@varsms+ "', '"+ @varmail+"')"
		@sqlstmmt2 = "INSERT INTO contactlinks (\"contactid\", \"addressid\") VALUES ('" + @id1 + "', '"+ @id2+ "')"
		sql.begin_db_transaction
		@id3 = sql.insert(@sqlcontact )
		sql.commit_db_transaction
		sql.begin_db_transaction
		@id3 = sql.insert(@sqlstmmt2 )
		sql.commit_db_transaction
		sql = ActiveRecord::Base.connection();
	    #sql staement to insert into prescription table
	    @sqlstmmt4 = "INSERT INTO prescriptions (\"physver\",recver,recexp) VALUES ('" + params[:physver] + "', '"+ params[:recver] + "', '"+ params[:recexp] +"')"
		#sql staement to insert into prescription table
		sql.begin_db_transaction
		@id4 = sql.insert(@sqlstmmt4)
		sql.commit_db_transaction
		@sqlstmmt5 = "INSERT INTO custphyslinks (\"customid\", \"physid\", prescid) VALUES ('" + session[:customer_id] + "', '"+ params[:pname]+ "', '"+@id4+"')"
		sql.begin_db_transaction
		@id6 = sql.insert(@sqlstmmt5)
		sql.commit_db_transaction
# Make Session to Nil after transactions
		session[:customer_id] = nil
		session[:physid] = nil
		flash[:customerpage] = "Customer has been successfully added."

	end
  end
end
   
   
   
  
def sales
   if  params[:commit] == "Submit"
	sql = ActiveRecord::Base.connection();
			flash[:finished] = nil 
		  if params[:paymenttype] == "Cash"
			if (session[:ordersid].nil? or session[:ordersid] == 0)
				sql.begin_db_transaction
				@sqladdorders = "INSERT INTO orders (custid,created_at,updated_at) VALUES ('" + session[:customerid] +"',current_date, current_date)"
				@orderid= sql.insert(@sqladdorders)
				session[:ordersid] = @orderid
				sql.commit_db_transaction
				session[:customerid] = nil
				session[:ordersid] = nil
			end
			sql.begin_db_transaction
				@sqladdpayment = "INSERT INTO payments (orderid, ttlprodcost, paytype, paystatus,created_at,updated_at,userid,storeid) VALUES ('" + "1"+ "', '" + "100" + "', '"  + 
				"1"+ "', '"  + "complete" +"',current_date, current_date, '"+"1"+"','"+
				session[:store_id]+"')"
				@paymentid= sql.insert(@sqladdpayment)
				session[:payid] = @paymentid
			sql.commit_db_transaction
			flash[:finished] = "Cash: Transaction has been paid. Thanks"
			@current_tab = 2
			@prods = Product.find(:all)
			@subjects1 = "SELECT * FROM cartitems where cid='"+session[:customerid]+"'"
			@subjects = Cartitem.find_by_sql(@subjects1)
			@cidstr = "cid = " + session[:customerid]
			Cartitem.delete_all()
		  else
		  if (session[:ordersid].nil? or session[:ordersid] == 0)
			sql.begin_db_transaction
			@sqladdorders = "INSERT INTO orders (custid) VALUES ('" + session[:customerid] +"')" 
			@orderid= sql.insert(@sqladdorders)
			session[:ordersid] = @orderid
			sql.commit_db_transaction
			end
			sql.begin_db_transaction
				@sqladdpayment = "INSERT INTO payments (custid,created_at,updated_at,userid,storeid) VALUES ('" + session[:customerid] +"',current_date, current_date, '"+"1"+"','"+"1"+"')"
				@paymentid= sql.insert(@sqladdpayment)
				session[:payid] = @paymentid
			sql.commit_db_transaction
			 flash[:finished] = "Credit :Your card has been charged. Thanks"
			@prods = Product.find(:all)
			@subjects1 = "SELECT * FROM cartitems where cid='"+session[:customerid]+"'"
			@subjects = Cartitem.find_by_sql(@subjects1)
			@cidstr = "cid = " + session[:customerid]
			Cartitem.delete_all()
		  end
			return
	  end
if params[:commit] == "delete"
		 @prods = Product.find(:all)
		 flash[:finished] = nil
	     sql = ActiveRecord::Base.connection();
         @subtotal = Cartitem.sum("price")
		 @totalprice = Cartitem.sum("(price-(price*(discount*.01))+price*.15)")
		 @sqladelcart = "DELETE FROM cartitems where id='"+params[:deleteId]+"'" 
		 @sqladelorddet = "DELETE FROM orderdetails where cartid='"+params[:deleteId]+"'" 
		 sql.begin_db_transaction
		 @id3= sql.delete(@sqladelcart)
		 flash[:result] = @sqladelcart
		 sql.commit_db_transaction
		  sql.begin_db_transaction
		 @id3= sql.delete(@sqladelorddet)
		 flash[:result] = @sqladelcart
		 sql.commit_db_transaction
		 @cidstr = "cid = " + session[:customerid]
		 @subtotal = Cartitem.sum("(price*(1-discount*.01))", :conditions => [@cidstr])
		 @totalprice = Cartitem.sum("(price-(price*(discount*.01))+price*.15)", :conditions => [@cidstr])
		 params[:stotal] = @subtotal 
		 params[:ttoal] =  @totalprice
		 flash[:notice] = @sqladelcart
		 @prods = Product.find(:all)
		 @subjects1 = "SELECT * FROM cartitems where cid='"+session[:customerid]+"'"
         @subjects = Cartitem.find_by_sql(@subjects1)
	return
	end
	if params[:commit] == "Add to Cart"
		if (session[:customerid].nil? or session[:customerid] == 0)
		flash[:search] = "Please select a customer in order to process payment"
		  redirect_to :controller => 'pages', :action => 'search' 
		end
			@prods = Product.find_by_id(params[:ptype])
			@condition = "prodid = '" +params[:ptype]+"'"
			@pid = @prods.prod_name
			@Productprice = Productprice.sum("priceperunit", :conditions => [@condition])
			@Discountprice = Proddiscount.sum("discount", :conditions => [@condition])
		@applymemdisc = "select Count(prodid) from orderdetails A, orders B where A.prodid='6' and A.orderid= B.id  and B.custid='"+session[:customerid]+"'"
		@indprodprice= @Productprice.to_s
		@inddisc = @Discountprice.to_s
		@prods = Product.find(:all)
		sql = ActiveRecord::Base.connection();
		@pid2 =  "SELECT * FROM products where prod_name='"+params[:ptype]+"'"
        @pid1 =   Product.find_by_sql(@pid2)
		@sqladdorders = "INSERT INTO orders (custid) VALUES ('" + session[:customerid] +"')" 
		if (session[:ordersid].nil? or session[:ordersid] == 0)
		sql.begin_db_transaction
			@orderid= sql.insert(@sqladdorders)
			session[:ordersid] = @orderid
		sql.commit_db_transaction
		end
		
		@sqladdcart = "INSERT INTO cartitems (cid,  pid, ptype, quality, quantity, price, discount,created_at,updated_at) VALUES ('" + session[:customerid]+ "', '"+ params[:ptype]  + "', '"+ @pid + "', '"+ params[:quality] +  "', '"+  params[:quantity]+  "', '"+     @indprodprice + "', '"+     @inddisc +"',current_date, current_date)"
		
		sql.begin_db_transaction
		@id3= sql.insert(@sqladdcart)
		sql.commit_db_transaction
		@sqladdorderdetails = "INSERT INTO orderdetails (orderid,  prodid, prodsaleprice, quantity,created_at,updated_at,status, cartid,userid,storeid) VALUES ('" + session[:ordersid]+ "', '"+ params[:ptype]  + "', '"+ @indprodprice + "', '"+ params[:quantity] +"',current_date, current_date, 'p','"+@id3+"','"+"2"+"','"+"2"+"')"
		sql.begin_db_transaction
			@orderdetailsid= sql.insert(@sqladdorderdetails)
		sql.commit_db_transaction
		@cidstr = "cid = " + session[:customerid]
		@subtotal = Cartitem.sum("(price*(1-discount*.01))", :conditions => [@cidstr])
		@totalprice = Cartitem.sum("(price-(price*(discount*.01))+price*.15)", :conditions => [@cidstr])
	if @totalprice.to_i >=25
		flash[:finished] = @query2
		@query1="select Count(*) from orderdetails A, orders B where A.prodid='5' and A.orderid= B.id and B.custid='"+session[:customerid]+"'"
		@query2 = Orderdetail.count_by_sql(@query1)
		@result="select Count(*) from orderdetails A, orders B where A.prodid='6' and A.orderid= B.id and B.custid='"+session[:customerid]+"'"
		@reult1 = Orderdetail.count_by_sql(@result)
		if @query2.to_i > 0
		if @reult1.to_i  <= 0 and @query2  = 1
		flash[:finished] = @query2
		@sqladdcart = "INSERT INTO cartitems (cid,  pid, ptype, quality, quantity, price, discount,created_at,updated_at) VALUES ('" + session[:customerid]+ "', '"+ "6"  + "', '"+ "Membership Discount" + "', '"+ "1" +  "', '"+  "1"+  "', '"+     "-25" + "', '"+ "0" +"',current_date, current_date)"
		sql.begin_db_transaction
		@id3= sql.insert(@sqladdcart)
		sql.commit_db_transaction
		@sqladdorderdetails = "INSERT INTO orderdetails (orderid,  prodid, prodsaleprice, quantity,created_at,updated_at,status, cartid,userid,storeid) VALUES ('" + session[:ordersid]+ "', '"+ "6"  + "', '"+ "-25" + "', '"+ "1" +"',current_date, current_date, 'p','"+@id3+"','"+"1"+"','"+"1"+"')"
		sql.begin_db_transaction
		@orderdetailsid= sql.insert(@sqladdorderdetails)
		sql.commit_db_transaction
		end
	end
	end
		@subtotal = Cartitem.sum("(price*(1-discount*.01))", :conditions => [@cidstr])
		@totalprice = Cartitem.sum("(price-(price*(discount*.01))+price*.15)", :conditions => [@cidstr])
		params[:stotal] = @subtotal 
		params[:ttoal] = @totalprice
	
        @prods = Product.find(:all)
		@subjects1 = "SELECT * FROM cartitems where cid='"+session[:customerid]+"'"
        @subjects = Cartitem.find_by_sql(@subjects1)
		return
else 
	 @cust = Customer.find_by_id(params[:custId])
	 @paramtemp = Product.find_by_id(:conditions => ["UPPER(prod_name) LIKE ?", "Flower".upcase])
	 @subtotal = Cartitem.sum("price")
	 @totalprice = Cartitem.sum("(price-(price*(discount*.01))+price*.15)")
 	 session[:customerid] = params[:custId]
	 @tempcustid = session[:customerid]
	   if (@tempcustid.nil? or @tempcustid == 0)
		  flash[:search] = "Please select a customer in order to process payment"
		  redirect_to :controller => 'pages', :action => 'search' 
		  return
		end
	 @cidstr = "cid = " + session[:customerid]
	 @subtotal = Cartitem.sum("(price*(1-discount*.01))", :conditions => [@cidstr])
	 @totalprice = Cartitem.sum("(price-(price*(discount*.01))+price*.15)", :conditions => [@cidstr])
	 params[:stotal] = @subtotal 
	 params[:ttoal] = @totalprice
     @subjects1 = "SELECT * FROM cartitems where cid='"+session[:customerid]+"'"
	 @subjects = Cartitem.find_by_sql(@subjects1)
	 @prods = Product.find(:all)

end
end
end

