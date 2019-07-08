require_relative './spec_helper'

RSpec.describe 'Toy robot language' do
  it 'prints' do
    s = Space.new
    result = capture_output { s.start_time }
    expect(result).to eq "3,1,SOUTH\n2,1,NORTH\n1,2,WEST\n1,0,EAST\n"
  end
end
