class Proddiscount < ActiveRecord::Base
	belongs_to :product, :foreign_key => "id"
		acts_as_audited
end
