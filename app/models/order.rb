class Order < ActiveRecord::Base
	has_many :orderdetail, :foreign_key => "orderid"
		acts_as_audited
end
