class Priority < ActiveRecord::Base
	
	validates :name, uniqueness: true
	has_many :distlists
	
	def to_s
		name
	end
end
