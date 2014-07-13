require_relative './weather'

class Airport

	include WeatherSystems

	DEFAULT_CAPACITY = 20

	def initialize(planes = [], capacity = DEFAULT_CAPACITY)
		@planes = planes
		@capacity = capacity
		@weather = local_weather
	end

	def hangar_contents
		@planes
	end

	def plane_count
		@planes.count
	end

	def full?
		plane_count == capacity
	end

	def clear_for_landing(plane)
			if !full? && self.local_weather == 'fine'
				plane.land!
				hangar_contents << plane
			else
				p 'Please reroute'
			end
	end


	def clear_for_take_off(plane)
		if self.local_weather == 'fine'
			plane.take_off!
			@planes = @planes.delete('plane')
		else
			p "Please wait for weather to improve"
		end
	end

	def self.automate_landing(planes)
    	available_airport = ((ObjectSpace.each_object(self).to_a).select{|airport| airport.local_weather == 'fine' && !airport.full?}).first
	  	planes.each do |plane|
	  		available_airport.clear_for_landing(plane)
  		end
  	end

  	def automate_take_off(planes)
  		planes.each {|plane| self.clear_for_take_off(plane)}
  	end

	def capacity
		@capacity ||= DEFAULT_CAPACITY
	end

end