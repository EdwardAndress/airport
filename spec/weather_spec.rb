require 'weather'

shared_examples 'it is effected by weather' do

	it 'by preventing a plane from landing if the weather is poor' do
		empty_airport.stub(:local_weather).and_return('stormy')
		empty_airport.clear_for_landing(plane)
		expect(empty_airport.plane_count).to eq 0
	end

	it 'by preventing a plane from taking off if the weather is not fine' do
		empty_airport.clear_for_landing(plane)
		empty_airport.stub(:local_weather).and_return('stormy', 'storm brewing')
		empty_airport.clear_for_take_off(plane)
		expect(empty_airport.plane_count).to eq 1
	end

end