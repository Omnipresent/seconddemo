class Store < ActiveRecord::Base
	has_many :userizations
	has_many :users, :through => :userizations 
	acts_as_audited
end
