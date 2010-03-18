class User < ActiveRecord::Base
	has_many :userizations
	has_many :stores, :through => :userizations 
	validates_presence_of :userid, :password
	acts_as_audited

  def self.authenticate(userid, password)
  		user = self.find_by_userid_and_password(userid, password)	    
    user
  end

end
