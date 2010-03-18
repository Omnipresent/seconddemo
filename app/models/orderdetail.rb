class Orderdetail < ActiveRecord::Base
	belongs_to :order,	:foreign_key => "orderid"
		acts_as_audited
end
