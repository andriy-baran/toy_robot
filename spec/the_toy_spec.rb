RSpec.describe TheToy do
  it "has a version number" do
    expect(TheToy::VERSION).not_to be nil
  end

  describe 'robot language' do
    it 'prints' do
      s = TheToy::Space.new
      result = capture_output { s.start_time }
      expect(result).to eq "3,1,SOUTH\n2,1,NORTH\n1,2,WEST\n1,0,EAST\n"
    end
  end
end
