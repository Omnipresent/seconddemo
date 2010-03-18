class Product < ActiveRecord::Base
	belongs_to :category	
	has_one 	:cartitem, :foreign_key => "id"
	has_one   :proddiscount, :foreign_key => "prodid"
	acts_as_audited
	
	#validates_presence_of :prod_name, :prod_orig_price, :prod_dis_price, :prod_promo
	#validates_numericality_of :prod_orig_price, :allow_nil => true
	#validates_numericality_of :prod_dis_price, :allow_nil => true
	
	HUMANIZED_ATTRIBUTES = {
		:prod_name => "Product name",
		:prod_orig_price => "Product price",
		:prod_dis_price => "Product discount price",
		:prod_promo => "Product promo code"
	}
	
	def self.human_attribute_name(attr)
		HUMANIZED_ATTRIBUTES[attr.to_sym] || super
	end

def category_product_name
  "#{self.category.name} - #{self.prod_name}"
end


end
