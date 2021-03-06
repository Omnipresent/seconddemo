class PagesController < ApplicationController
	layout "application", :except => [:index, :mainpage]
	
	def volume_or_quant
		@product = Product.find(params[:id])
		@product.quantity		;
		render :text => @product.volume
	end
	
	def edit_product			
	  @categories = Category.all
		@products = Product.find_by_id(params[:id])
		@prod_cat = @products.category
		if request.post?
			if (Product.update(params[:id], params[:product]) != nil)
			@proddiscount = Proddiscount.find_by_prodid(params[:id])
			@proddiscount.update_attribute(:discount, params[:discount])
#			Proddiscount.update({:prodid => params[:id]}, {:discount=>params[:discount]})
		  	redirect_to :controller => 'pages', :action => 'product' 
		  end
		end
	end
	
	def product
	  @categories = Category.all
		@products = Product.new

			@prods = Product.find(:all)
			flash[:product] = "Currently there are #{@prods.size} products"
		if request.post?
		@products = Product.new(params[:product])
			if (@products.save)
				@prods = Product.find(:all)
				Proddiscount.create(:prodid=>@products.id, :discount=>params[:discount])
				@products = Product.new
				flash[:product] = "Product #{params[:pname]} saved successfully"
			end
		end
	end
	
	def physician
		@physician = Physician.new
		if request.post?
			@physician = Physician.new(params[:physician])
			if @physician.save
				flash[:physician_save] = "Physician Informaiton saved"
			end
		end
		
	end
	
	def mainpage
		@user = User.find(session[:user_id])
		@userType = @user.user_type
	end
	
  def about
  end
  
  def reports
  end

  
  def patient
  	
  end
  
  def search
  	session[:customerid] = nil
		session[:ordersid] = nil
		if params[:type] == "Member"
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
			params[:type] = "Member"
		#	flash[:search] = "Total #{@customer.size} #{params[:type]}" unless @customer == nil
		else
			flash[:search] = "Found #{@customer.size} #{params[:type]}s" unless @customer == nil
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
 if params[:commit] == "Update Member Information"
  if (params[:line2].nil? or params[:line2] == "")
	  @varline2 = " "
	else
	@varline2 = params[:line2]
	 end
  @varinsert = {:firstname=>params[:firstname], :lastname=>params[:lastname], :dob=>params[:dob],:dln=>params[:dln],:sex=>params[:sex], :referral=>params[:referral], :reffredby=>params[:reffredby],:notes=>params[:notes],:statemmp=>params[:statemmp],:recom=>params[:recom], :countyid=>params[:countyid], :suffix=>params[:suffix], :dlnstate=>params[:dlnstate], :dlnexpiry=>params[:dlnexp]}
  @cust = Customer.update(@custid, @varinsert)
  @varinsert = {:line1=>params[:line1] , :county=>params[:county], :line2=>@varline2, :city=>params[:city],:state=>params[:state], :zip=>params[:zip]}
  @ad = Address.find_by_cid(@custid)
  if @ad != nil
    @cust = Address.update_all(@varinsert, "cid = " + @custid)
  else
    @cust = Customer.find(@custid)
    @cust = @cust.create_address(@varinsert)
  end
  
if (params[:sms].nil? or params[:sms] == 0)
	    @varsms = "no"
	else
	@varsms = "yes"
	 end
if (params[:mail].nil? or params[:mail] == 0)
	    @varmail = "no"
	else
	@varmail = "yes"
	 end
 if (params[:email].nil? or params[:email] == 0)
	    @varemail = "no"
	else
	@varemail = "yes"
	 end
	if (params[:phone].nil? or params[:phone] == 0)
	    @varphone = "no"
	else
	@varphone = "yes"
	 end	
  @varinsert = {:hphone=>params[:hphone] , :mphone=>params[:mphone], :cemail=>params[:cemail], :provider=>params[:provider], :mail=>@varmail, :email=>@varemail, :sms=>@varsms, :phone=>@varphone}
  @cust = Contact.update_all(@varinsert, "cid = " + @custid)
  flash[:edit_customer]= "Member Information Updated"
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
if @customer.first.address != nil
params[:line1]  = @customer.first.address.line1 
params[:county] = @customer.first.address.county
params[:line2] = @customer.first.address.line2
params[:city] = @customer.first.address.city
params[:state] = @customer.first.address.state
params[:zip] = @customer.first.address.zip
end
params[:hphone] = @customer.first.contact.hphone
params[:mphone] = @customer.first.contact.mphone
params[:cemail] = @customer.first.contact.cemail
params[:provider] = @customer.first.contact.provider
params[:email] =  @customer.first.contact.email
params[:mail] =  @customer.first.contact.mail
params[:sms] =  @customer.first.contact.sms
params[:phone] =  @customer.first.contact.phone
end
end  


 


#end edit customer


#start customer

 def customer
    @phys = Physician.find(:all) #gets all physicians
    if request.post?
      
      if params[:commit] == "save" #save from physician modal page
        @phys = Physician.new(:address => params[:address], :pname => params[:pname1], :degree => params[:pdegree], :pgroup => params[:pgroup1], :plicnum => params[:plicnum1], :licexpdate => params[:licexpdate1])
        @phys.save
        @physid = @phys.id
        session[:physid]  = @physid
    	  flash[:customerpage] = "Added Physician" 
  	    @phys = Physician.find(:all) 
      end
      
      if params[:commit] == "Add Member Information" #Add member information
@cust = Customer.new(:firstname => params[:firstname], :lastname => params[:lastname], :dob => params[:dob], :dln => params[:dln], :sex => params[:sex], :referral => params[:referral], :reffredby => params[:reffredby], :notes => params[:notes], :statemmp => params[:statemmp], :recom => params[:recom], :countyid => params[:countyid], :suffix => params[:suffix], :dlnstate => params[:dlnstate], :dlnexpiry => params[:dlnexp])
@cust.save		 

   

  		 @addy = @cust.create_address(:line1 => params[:line1], :line2 => params[:line2], :city => params[:city], :state => params[:state], :zip => params[:zip], :county => params[:county])
       @addy.save
       puts @addy.id.to_s + "THIS IS ADDRESS IDDDDDDDDDDD"
		 @@sides =  params[:firstName]
		 @id1 = @cust.id
		 session[:customer_id] = @id1
		 @id2 = @addy.id

    	if (params[:sms].nil? or params[:sms] == 0)
    	 @varsms = "no"
    	else
      	@varsms = "yes"
    	end
      if (params[:mail].nil? or params[:mail] == 0)
  	    @varmail = "no"
    	else
      	@varmail = "yes"
    	end
      if (params[:email].nil? or params[:email] == 0)
  	    @varemail = "no"
    	else
      	@varemail = "yes"
    	end
      if (params[:phone].nil? or params[:phone] == 0)
  	    @varphone = "no"
    	else
      	@varphone = "yes"
    	end	

      @cont = Contact.new(:id => @id1, :cid => @id1, :hphone => params[:hphone], :mphone => params[:mphone], :provider => params[:provider], :cemail => params[:cemail], :email => @varemail, :sms => @varsms, :mail => @varmail, :phone => @varphone)
      @cont.save

      @contlink = Contactlink.new(:contactid => @id1, :addressid => @id2)
      @contlink.save

  		@id3 = @cont.id
  		@id3 = @contlink.id
      @pres = Prescription.new(:physver => params[:physver], :recver => params[:recver], :recexp => params[:recexp])
      @pres.save	    
  		@id4 = @pres.id

      @custphylink = Custphyslink.new(:customid => session[:customer_id], :physid => params[:pname], :prescid => @id4)    	
      @custphylink.save

		@id6 = @custphylink.id

# Make Session to Nil after transactions
		session[:customer_id] = nil
		session[:physid] = nil
		flash[:edit_customer] = "Member has been successfully added."
		redirect_to :controller => 'pages', :action => 'search'
	end # end Add member information
  end
end

#end customer


   
   def to_frac(value)
		numerator, denominator = value.split('/').map(&:to_f)
    denominator ||= 1
    numerator/denominator   	
   end
  
def sales
	if  params[:commit] == "Complete Transaction" #complete transaction
		session[:customer_id] = nil
		session[:ordersid] = nil
		session[:custId] = nil
		session[:totalcost] = nil
		session[:stotalcost] = nil
	end
  if  params[:commit] == "Submit"
  	sql = ActiveRecord::Base.connection();
		flash[:finished] = nil
	  if params[:paymenttype] == "Cash"
			if (session[:ordersid].nil? or session[:ordersid] == 0)
				sql.begin_db_transaction
				puts "session id: " + session[:customerid].to_s
				@orderid = Order.find_by_custid(session[:customerid])
				session[:ordersid] = @orderid.id.to_s
				sql.commit_db_transaction
			end
			#sql.begin_db_transaction
			puts "orderid: " + session[:ordersid].to_s
			puts "ttlprodcost: " + session[:totalcost].to_s
			@payment = Payment.new(:orderid => session[:ordersid], :ttlprodcost => session[:totalcost], :paytype => '1', :paystatus => 'complete')
			@payment.save
			@paymentid= @payment.id
puts "one!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
			session[:payid] = @paymentid
			#sql.commit_db_transaction
			flash[:finished] = "Transaction has been completed. Thanks"
			@current_tab = 2
			@prods = Product.find(:all)
			puts "session id2: " + session[:customerid].to_s
			@subjects = Cartitem.find_all_by_cid(session[:customerid])
			Cartitem.delete_all("cid = " + session[:customerid])
	  else #else for cash
		  if (session[:ordersid].nil? or session[:ordersid] == 0)
				#sql.begin_db_transaction
				#@sqladdorders = "INSERT INTO orders (custid) VALUES ('" + session[:customerid] +"')" 
				@order = Order.new(:custid => session[:customerid])
				@order.save
				@orderid= @order.id
				session[:ordersid] = @orderid
puts "two!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
				#sql.commit_db_transaction
			end
			#sql.begin_db_transaction
			@payment = Payment.new(:custid=>session[:customerid])
			@payment.save
			@paymentid= @payment.id
			session[:payid] = @paymentid
puts "three!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
			#sql.commit_db_transaction
			flash[:finished] = "Your card has been charged. Thanks"
			@current_tab = 2
			@prods = Product.find(:all)
		#	@subjects1 = "SELECT * FROM cartitems where cid='"+session[:customerid]+"'"
			@subjects = Cartitem.find_all_by_cid(session[:customerid])
		#	@cidstr = "cid = " + session[:customerid]
		#	Cartitem.delete_all(@cidstr)
			Cartitem.delete_all(["cid = ?", session[:customerid]])
puts session[:customerid].to_s + "four!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
	  end #end else
		return
	end#end submit 
  if params[:commit] == "delete"
			@cust = Customer.find_by_id(session[:custId])
			@prods = Product.find(:all)
		  flash[:finished] = nil
	    sql = ActiveRecord::Base.connection();
      @subtotal = Cartitem.sum("price")
		  @totalprice = Cartitem.sum("(price-(price*(discount*.01))+price*.0875)")
		  #@sqladelcart = "DELETE FROM cartitems where id='"+params[:deleteId]+"'" 
		  #@sqladelorddet = "DELETE FROM orderdetails where cartid='"+params[:deleteId]+"'" 
		 # sql.begin_db_transaction
		  Cartitem.delete_all(['id = ?', params[:deleteId]])
		  #@id3= sql.delete(@sqladelcart)
		  #flash[:result] = @sqladelcart
		  #sql.commit_db_transaction
		  #sql.begin_db_transaction
		  Orderdetail.delete_all(['cartid = ?', params[:deleteId]])
		  #@id3= sql.delete(@sqladelorddet)
		  #flash[:result] = @sqladelcart
		  #sql.commit_db_transaction
		  @cidstr = "cid = " + session[:customerid]
  		@subtotal = Cartitem.sum("(price*to_number(quantity, '99G999D9S'))-(discount*to_number(quantity, '99G999D9S'))", :conditions => [@cidstr])
  		@totalprice = Cartitem.sum("(price*to_number(quantity, '99G999D9S')-(discount*to_number(quantity, '99G999D9S'))+price*to_number(quantity,'99G999D9S')*.0875)", :conditions => [@cidstr])
		  params[:stotal] = @subtotal 
		  params[:ttoal] =  @totalprice
		  flash[:notice] = @sqladelcart
		  @prods = Product.find(:all)
		  #@subjects1 = "SELECT * FROM cartitems where cid='"+session[:customerid]+"'"
      @subjects = Cartitem.find_all_by_cid(session[:customerid])
puts "five!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"      
      
	    return
	end#end delete
	if params[:commit] == "Add to Cart"
			@salecondition = "id = " + params[:product][:prod_name]
			@Quantity = Product.sum("quantity", :conditions => [@salecondition])
		  @qnty = @Quantity.to_i - params[:quantity].to_i
		  if @qnty < 0
				flash[:sale] = "Not enough Quantity"
		    @subjects1 = "SELECT * FROM cartitems where cid='"+session[:customerid]+"'"
				@subjects = Cartitem.find_by_sql(@subjects1)
				@prods = Product.find(:all)
			 return
			end
		  puts @qnty 
		  @cust = Customer.find_by_id(session[:custId])
		  if (session[:customerid].nil? or session[:customerid] == 0)
				flash[:search] = "Please select a customer in order to process payment"
			  redirect_to :controller => 'pages', :action => 'search' 
			end
	    @prods = Product.find_by_id(params[:product][:prod_name])
			@condition = "id = '" +params[:product][:prod_name]+"' and volume= '"+params[:quantity].to_s+"'"
			@condition1 = "prodid = '" +params[:product][:prod_name]+"'"
			@pid = @prods.prod_name
			@Productprice = Product.sum("prod_orig_price", :conditions => [@condition])
			@Discountprice = Proddiscount.sum("discount", :conditions => [@condition1])
			@applymemdisc = "select Count(prodid) from orderdetails A, orders B where A.prodid='6' and A.orderid= B.id  and B.custid='"+session[:customerid]+"'"
			@indprodprice= @prods.prod_orig_price.to_s
			if params[:volume].to_s.length > 0
				puts "came here"
				first, *rest = params[:volume].to_s.split(/ /)
				if rest.first=="oz"
					@indprodprice = @prods.prod_orig_price.to_f*to_frac(first)*28.3495
				elsif rest.first=="lb" 
					@indprodprice = @prods.prod_orig_price.to_f*to_frac(first)*453.59237
			  elsif rest.first=="g"
			  	@indprodprice = @prods.prod_orig_price.to_f*to_frac(first)
				end		
			end
		  @indprodprice = @indprodprice.to_s
			@pconditions = @prods.conditions
		  @prodType = @prods.prod_type
		  @prodrating = @prods.rating
		  @prodthc = @prods.thc
		  @prodCat = @prods.category.name
		  @inddisc = @Discountprice.to_s
		  @prods = Product.find(:all)
		  sql = ActiveRecord::Base.connection();
		  @pid2 =  "SELECT * FROM products where prod_name='"+params[:product][:prod_name]+"'"
      @pid1 =   Product.find_by_sql(@pid2)
		  @sqladdorders = "INSERT INTO orders (custid) VALUES ('" + session[:customerid] +"')" 
		  if (session[:ordersid].nil? or session[:ordersid] == 0)
				sql.begin_db_transaction
				@orderid= sql.insert(@sqladdorders)
				session[:ordersid] = @orderid
				sql.commit_db_transaction
			end
			#quality is obsolete. it is replaced by rating - bhaarat
			if params[:quantity].to_s.length <=0
					puts "HEREEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE"
					@quant = 1
			else
					@quant = params[:quantity]
					puts "yooooooooooooooooooooooooooooooooooo: " + "#{params[:quantity].to_s.length}"
			end

#			@sqladdcart = "INSERT INTO cartitems (volume, category_name, thc,rating,prodtype,conditions, cid,  pid, ptype, quality, quantity, price, discount,created_at,updated_at) VALUES ('"+params[:volume].to_s+"','"+ @prodCat +"','"+ @prodthc + "','"+ @prodrating + "','" + @prodType +"','"+ @pconditions +"','" + session[:customerid]+ "', '"+ params[:product][:prod_name] + "', '"+ @pid + "', '"+ '0' +  "', '"+  @quant.to_s+  "', '"+     @indprodprice + "', '"+     @inddisc +"',current_date, current_date)"

      @citems = Cartitem.new(:volume => params[:volume], :category_name => @prodCat, :thc => @prodthc, :rating => @prodrating, :prodtype => @prodType, :conditions => @pconditions, :cid => session[:customerid], :pid => params[:product][:prod_name], :ptype => @pid, :quality => "0", :quantity => @quant.to_s, :price => @indprodprice, :discount => @inddisc)
@citems.save
		#	sql.begin_db_transaction
			@id3= @citems.id
			#sql.commit_db_transaction

			@quant = params[:quantity]
			puts "Quant!!!!!!!!!!!!!!!!!!!!!!!! " + @quant.to_s
			if @quant.to_s.length <= 0
				@quant = 0;
		  end
		#	@sqladdorderdetails = "INSERT INTO orderdetails (orderid,  prodid, prodsaleprice, quantity,created_at,updated_at,status, cartid,userid,storeid) VALUES ('" + session[:ordersid]+ "', '"+params[:product][:prod_name]  + "', '"+ @indprodprice + "', '" +@quant.to_s+"',current_date, current_date, 'p','"+@id3+"','"+"2"+"','"+"2"+"')"
			@odtails = Orderdetail.new(:orderid => session[:ordersid], :prodid => params[:product][:prod_name], :prodsaleprice => @indprodprice, :quantity=>@quant.to_s, :status=>'p', :cartid => @id3, :userid=>'2', :storeid=>'2')
			@odtails.save
			
			#sql.begin_db_transaction
			@orderdetailsid= @odtails.id
		#	sql.commit_db_transaction
			@cidstr = "cid = " + session[:customerid]
		@subtotal = Cartitem.sum("(price*to_number(quantity, '99G999D9S'))-(discount*to_number(quantity, '99G999D9S'))", :conditions => [@cidstr])
		@totalprice = Cartitem.sum("(price*to_number(quantity, '99G999D9S')-(discount*to_number(quantity, '99G999D9S'))+price*to_number(quantity,'99G999D9S')*.0875)", :conditions => [@cidstr])
			if @subtotal.to_i >25
		#flash[:finished] = @query2
		@membership = Product.find_by_prod_name("Membership")
		@memberdiscount = Product.find_by_prod_name("Membership Discount")
		@query2 =  0
		if @membership != nil
  		@query1="select Count(*) from orderdetails A, orders B where A.prodid='"+@membership.id.to_s+"' and A.orderid= B.id and B.custid='"+session[:customerid]+"'" 
  		@query2 = Orderdetail.count_by_sql(@query1)
  	end
  	@result1 = 0
  	if @memberdiscount != nil
  		@result="select Count(*) from orderdetails A, orders B where A.prodid='"+@memberdiscount.id.to_s+"' and A.orderid= B.id and B.custid='"+session[:customerid]+"'"
  		@reult1 = Orderdetail.count_by_sql(@result)
  		@o = Orderdetail.count(:joins => :order, :conditions => ["prodid = ? and orders.custid = ?", @memberdiscount.id, session[:customerid]])
  		@c = Cartitem.all(:conditions => ["cid = ? and ptype = ?", session[:customerid], "Membership Discount"])
  		@c1 = Cartitem.all(:conditions => ["cid = ? and ptype = ?", session[:customerid], "Membership"])
  	end
		if @query2.to_i > 0
#		@reult1.to_i  <= 0 and @query2  = 1
puts "o: " + @o.to_s
puts "c: " + @c.size.to_s
puts "c1" + @c1.size.to_s
puts "result1: " + @result1.to_s
puts "query2: " + @query2.to_s

		if (@reult1.to_i  <= 0 and @query2  == 1 and @o == 0 and @c.size == 0 and @c1.size == 1)
		#flash[:finished] = @query2
		puts "Entered here!!!!!!!!!!!!!!"
		@sqladdcart = "INSERT INTO cartitems (category_name, cid,  pid, ptype, quality, quantity, price, discount,created_at,updated_at) VALUES ('"+ 'Membership Discount'+"' ,  '" + session[:customerid]+ "', '"+ @memberdiscount.id.to_s  + "', '"+ "Membership Discount" + "', '"+ "1" +  "', '"+  "1"+  "', '"+     "-25" + "', '"+ "0" +"',current_date, current_date)"
		sql.begin_db_transaction
		@id3= sql.insert(@sqladdcart)
		sql.commit_db_transaction
		
		@sqladdorderdetails = "INSERT INTO orderdetails (orderid,  prodid, prodsaleprice, quantity,created_at,updated_at,status, cartid,userid,storeid) VALUES ('" + session[:ordersid]+ "', '"+ @memberdiscount.id.to_s  + "', '"+ "-25" + "', '"+ "1" +"',current_date, current_date, 'p','"+@id3+"','"+"1"+"','"+"1"+"')"
		sql.begin_db_transaction
		@orderdetailsid= sql.insert(@sqladdorderdetails)
		sql.commit_db_transaction
		end
	end
	end
		@subtotal = Cartitem.sum("(price*to_number(quantity, '99G999D9S'))-(discount*to_number(quantity, '99G999D9S'))", :conditions => [@cidstr])
		@totalprice = Cartitem.sum("(price*to_number(quantity, '99G999D9S')-(discount*to_number(quantity, '99G999D9S'))+price*to_number(quantity,'99G999D9S')*.0875)", :conditions => [@cidstr])
		params[:stotal] = @subtotal 
		params[:ttoal] = @totalprice
		session[:totalcost] = @totalprice
		session[:stotalcost] = @subtotal
        @prods = Product.find(:all)
		@subjects1 = "SELECT * FROM cartitems where cid='"+session[:customerid]+"'"
        @subjects = Cartitem.find_by_sql(@subjects1)
		return
else 
	 @cust = Customer.find_by_id(params[:custId])
	 @paramtemp = Product.find_by_id(:conditions => ["UPPER(prod_name) LIKE ?", "Flower".upcase])
	 @subtotal = Cartitem.sum("price")
	 @totalprice = Cartitem.sum("(price-(price*(discount*.01))+price*.0875)")
 	 session[:customerid] = params[:custId]
	 @tempcustid = session[:customerid]
	   if (@tempcustid.nil? or @tempcustid == 0)
		  flash[:search] = "Please select a customer in order to process payment"
		  redirect_to :controller => 'pages', :action => 'search'
		  return
		end
	session[:custId] = @cust.id
	session[:customername] = @cust.lastname + ", "+@cust.firstname
	session[:custid] = @cust.id
	 @cidstr = "cid = " + session[:customerid]
	 @subtotal = Cartitem.sum("(price*to_number(quantity, '99G999D9S'))-(discount*to_number(quantity, '99G999D9S'))", :conditions => [@cidstr])
	 @totalprice = Cartitem.sum("(price*to_number(quantity, '99G999D9S')-(discount*to_number(quantity, '99G999D9S'))+price*to_number(quantity,'99G999D9S')*.0875)", :conditions => [@cidstr])
	 params[:stotal] = @subtotal
	 params[:ttoal] = @totalprice
     @subjects1 = "SELECT * FROM cartitems where cid='"+session[:customerid]+"'"
	 @subjects = Cartitem.find_by_sql(@subjects1)
	 @prods = Product.find(:all)

end
end
end

