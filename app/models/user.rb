class User < ActiveRecord::Base
	has_many :userizations
	has_many :stores, :through => :userizations 
	validates_presence_of :userid, :password

  def self.authenticate(userid, password)
  	puts "test"
  		user = self.find_by_userid_and_password(userid, password)	    
    user
  end

end
