require 'plane'

describe Plane do
 
  let(:plane) 	{ Plane.new }
  let(:airport)	{double :airport, full?: :true}
  
  it 'has a status of "Grounded" when created' do
  	expect(plane.status).to eq 'Grounded'
  end
  
  it 'changes its status to "In flight" after taking off' do
  	plane.take_off!
  	expect(plane.status).to eq 'In flight'
  end

  it 'changes it status to "Grounded" after landing' do
    plane.land!
    expect(plane.status).to eq 'Grounded'
  end

end