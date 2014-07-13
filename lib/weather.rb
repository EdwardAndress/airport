module WeatherSystems

	def local_weather
		@weather ||= weather_update
	end

	def weather_update
		@weather = (['fine', 'fine', 'fine', 'fine', 'fine', 'fine', 'stormy', 'storm brewing'].shuffle.first)
	end

end