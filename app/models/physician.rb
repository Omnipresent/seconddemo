class Physician < ActiveRecord::Base
validates_presence_of :pname, :plicnum

	HUMANIZED_ATTRIBUTES = {
		:pname => "Physician Name",
		:degree => "Physician Degree",
		:pgroup => "Physician Group",
		:plicnum => "Physician License ",
		:licexpdate => "Physician license exp date"
	}

	def self.human_attribute_name(attr)
		HUMANIZED_ATTRIBUTES[attr.to_sym] || super
	end


end
