# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100323021747) do

  create_table "addresses", :force => true do |t|
    t.string   "line1"
    t.string   "line2"
    t.string   "city"
    t.string   "state"
    t.string   "county"
    t.string   "zip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "userid"
    t.integer  "storeid"
  end

  create_table "audits", :force => true do |t|
    t.integer  "auditable_id"
    t.string   "auditable_type"
    t.integer  "user_id"
    t.string   "user_type"
    t.string   "username"
    t.string   "action"
    t.text     "changes"
    t.integer  "version",        :default => 0
    t.string   "comment"
    t.datetime "created_at"
  end

  add_index "audits", ["auditable_id", "auditable_type"], :name => "auditable_index"
  add_index "audits", ["created_at"], :name => "index_audits_on_created_at"
  add_index "audits", ["user_id", "user_type"], :name => "user_index"

  create_table "cartitems", :force => true do |t|
    t.string   "pid"
    t.string   "ptype"
    t.string   "itemname"
    t.string   "quality"
    t.string   "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "cid"
    t.decimal  "price"
    t.string   "conditions"
    t.string   "prodtype"
    t.string   "rating"
    t.string   "thc"
    t.string   "category_name"
    t.string   "volume"
    t.string   "status"
    t.integer  "order_id"
    t.decimal  "discount"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contactlinks", :force => true do |t|
    t.string   "contactid"
    t.string   "addressid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contacts", :force => true do |t|
    t.string   "hphone"
    t.string   "mphone"
    t.string   "provider"
    t.string   "cemail"
    t.string   "email"
    t.string   "sms"
    t.string   "mail"
    t.string   "group"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "cid"
    t.integer  "userid"
    t.integer  "storeid"
    t.string   "phone"
  end

  create_table "customers", :force => true do |t|
    t.string   "lastname"
    t.string   "firstname"
    t.string   "dln"
    t.string   "sex"
    t.string   "referral"
    t.string   "reffredby"
    t.string   "notes"
    t.string   "statemmp"
    t.string   "recom"
    t.string   "countyid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "suffix"
    t.string   "dlnstate"
    t.string   "dlnexpiry"
    t.integer  "userid"
    t.integer  "storeid"
    t.string   "dob"
  end

  create_table "custphyslinks", :force => true do |t|
    t.string   "customid"
    t.string   "physid"
    t.string   "prescid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orderdetails", :force => true do |t|
    t.integer  "orderid"
    t.integer  "prodid"
    t.integer  "productpriceid"
    t.integer  "proddiscountid"
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
    t.string   "cartid"
    t.integer  "userid"
    t.integer  "storeid"
    t.decimal  "prodsaleprice"
  end

  create_table "orders", :force => true do |t|
    t.integer  "custid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "userid"
    t.integer  "storeid"
  end

  create_table "paymentdistributions", :force => true do |t|
    t.integer  "payid"
    t.integer  "taxtypeid"
    t.integer  "taxamnt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "userid"
    t.integer  "storeid"
  end

  create_table "payments", :force => true do |t|
    t.integer  "orderid"
    t.integer  "prodid"
    t.string   "paytype"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "paystatus"
    t.integer  "custid"
    t.integer  "userid"
    t.integer  "storeid"
    t.string   "ttlprodcost"
  end

  create_table "physicians", :force => true do |t|
    t.string   "pname"
    t.string   "degree"
    t.string   "pgroup"
    t.string   "plicnum"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "userid"
    t.integer  "storeid"
    t.string   "licexpdate"
    t.string   "address"
  end

  create_table "prescriptions", :force => true do |t|
    t.string   "physver"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "userid"
    t.integer  "storeid"
    t.string   "recver"
    t.string   "recexp"
  end

  create_table "proddiscounts", :force => true do |t|
    t.integer  "prodid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "discountfrom"
    t.string   "discountto"
    t.decimal  "discount"
  end

  create_table "productprices", :force => true do |t|
    t.integer  "prodid"
    t.integer  "priceperunit"
    t.integer  "unit"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", :force => true do |t|
    t.string   "prod_name"
    t.decimal  "prod_orig_price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id"
    t.string   "conditions"
    t.string   "rating"
    t.string   "thc"
    t.string   "volume"
    t.integer  "quantity"
    t.string   "prod_type"
  end

  create_table "stores", :force => true do |t|
    t.string   "store_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "store_poc"
    t.string   "created_by"
    t.string   "store_status"
  end

  create_table "userizations", :force => true do |t|
    t.integer  "user_id"
    t.integer  "store_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "userid"
    t.string   "password"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_first_name"
    t.string   "user_last_name"
    t.string   "user_status"
    t.string   "user_type"
  end

end
