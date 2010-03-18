class Userization < ActiveRecord::Base
	belongs_to	:store
	belongs_to	:user
	acts_as_audited
end
