class Plane

	def initialize
		@status = "Grounded"
	end

	def status
		@status
	end

	def land!
		@status = "Grounded"
		self
	end

	def take_off!
		@status = "In flight"
		self
	end

	def self.all
    	ObjectSpace.each_object(self).to_a
  	end

end