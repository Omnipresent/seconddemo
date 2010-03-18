class Cartitem < ActiveRecord::Base
	belongs_to :product, :foreign_key => "pid"
		acts_as_audited
end
