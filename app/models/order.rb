class Order < ActiveRecord::Base
	has_many :orderdetail, :foreign_key => "orderid"
end
