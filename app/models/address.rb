class Address < ActiveRecord::Base
		belongs_to :customer, :foreign_key => "cid"
		
validates_presence_of :line1,:city
validates_numericality_of :zip
	acts_as_audited
end
