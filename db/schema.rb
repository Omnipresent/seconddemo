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

ActiveRecord::Schema.define(:version => 20100128032029) do

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

  create_table "cartitems", :force => true do |t|
    t.string   "pid"
    t.string   "ptype"
    t.string   "itemname"
    t.string   "quality"
    t.string   "quantity"
    t.integer  "price"
    t.integer  "discount"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "cid"
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
  end

  create_table "customers", :force => true do |t|
    t.string   "lastname"
    t.string   "firstname"
    t.date     "dob"
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
    t.integer  "prodsaleprice"
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
    t.string   "cartid"
    t.integer  "userid"
    t.integer  "storeid"
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
    t.date     "licexpdate"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "userid"
    t.integer  "storeid"
  end

  create_table "prescriptions", :force => true do |t|
    t.date     "recver"
    t.date     "recexp"
    t.string   "physver"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "userid"
    t.integer  "storeid"
  end

  create_table "proddiscounts", :force => true do |t|
    t.integer  "prodid"
    t.integer  "discount"
    t.date     "discountfrom"
    t.date     "discountto"
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.integer  "prod_dis_per"
    t.decimal  "prod_dis_price"
    t.string   "prod_promo"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "userid"
    t.integer  "storeid"
  end

  create_table "stores", :force => true do |t|
    t.integer  "store_id"
    t.string   "store_name"
    t.datetime "created_at"
    t.datetime "updated_at"
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
  end

  create_table "z1schema_migrations", :id => false, :force => true do |t|
    t.string "version", :null => false
  end

  create_table "zschema_migrations", :id => false, :force => true do |t|
    t.string "version", :null => false
  end

  add_index "zschema_migrations", ["version"], :name => "unique_schema_migrations", :unique => true

end
