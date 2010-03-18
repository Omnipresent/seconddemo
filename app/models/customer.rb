class Customer < ActiveRecord::Base
	has_one 	:contact, :foreign_key => "cid"
	has_one 	:address, :foreign_key => "id"
		acts_as_audited
end
