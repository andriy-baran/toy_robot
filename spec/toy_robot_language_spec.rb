require_relative './spec_helper'

RSpec.describe 'Toy robot language' do
  it 'prints' do
    file = File.open('test.txt')
    @scenario = Scenario.new(file)
    result = capture_output { @scenario.play }
    expect(result).to eq "3,3,NORTH\n2,1,SOUTH\n1,0,WEST\n3,0,WEST\n"
  end
end
