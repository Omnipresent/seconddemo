class Cartitem < ActiveRecord::Base
	belongs_to :product, :foreign_key => "pid"
end
