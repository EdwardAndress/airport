require './lib/airport'
require './spec/weather_spec'

def fill_hangars(airport_x)
  20.times {airport_x.clear_for_landing(plane)}
end
 
describe Airport do

  it_behaves_like 'it is effected by weather'

  let(:airport)            {Airport.new(plane)}
  let(:empty_airport)      {Airport.new}
  let(:available_airport)  {Airport.new}
  let(:plane)              {double :plane, land!: :Grounded, take_off!: :"In flight", delete: [], count: 20}
  let(:plane2)             {double :plane2, land!: :Grounded, take_off!: :"In flight", delete: []}

  context 'Air traffic control should' do

    it 'make a plane land' do
      empty_airport.stub(:local_weather).and_return('fine')
      expect(plane2).to receive(:land!)
      empty_airport.clear_for_landing(plane2)
    end

    it 'make a plane take off' do
      airport.stub(:local_weather).and_return('fine')
      expect(plane).to receive(:take_off!).and_return("In flight")
      airport.clear_for_take_off(plane)
    end

    it 'not allow planes to land once hangars are full' do
      empty_airport.stub(:local_weather).and_return('fine')
      fill_hangars(empty_airport)
      empty_airport.clear_for_landing(plane2)
      expect(empty_airport.plane_count).to eq 20
    end

    xit 'automate the landing of multiple planes at suitable airports' do
      planes = [plane, plane2]
      Plane.automate_landing(planes)
      expect(available_airport.plane_count).to eq 2
    end

    xit 'automate the departure of multiple planes' do
      empty_airport.stub(:local_weather).and_return('fine')
      empty_airport.clear_for_landing(plane)
      empty_airport.clear_for_landing(plane2)
      p = empty_airport.hangar_contents
      empty_airport.automate_take_off(p)
      expect(empty_airport.plane_count).to eq 0
    end
  end

  context 'The airport should' do

    it 'know how many planes are stored' do
      expect(airport.hangar_contents).to eq(plane)
    end

    it 'update the @planes list after a plane lands' do
      empty_airport.stub(:local_weather).and_return('fine')
      empty_airport.clear_for_landing(plane)
      expect(empty_airport.hangar_contents).to eq [plane]
    end

    it 'update the @planes list after a plane takes off' do
      airport.stub(:local_weather).and_return('fine')
      airport.clear_for_take_off(plane)
      expect(airport.hangar_contents).to eq []
    end

    it 'have a default capacity of 20 planes' do
      expect(airport.capacity).to eq 20
    end

    it 'know when the capacity is reached' do
      empty_airport.stub(:local_weather).and_return('fine')
      fill_hangars(empty_airport)
      expect(empty_airport).to be_full
    end

  end

end