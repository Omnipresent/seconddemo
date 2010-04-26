class Contact < ActiveRecord::Base
	belongs_to :customer, :foreign_key => "cid"
		#acts_as_audited
end
