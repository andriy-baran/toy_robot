class Position
	
  attr_reader :x, :y, :size
  
  def initialize(x: nil, y: nil, size: 5)
    @x = x
    @y = y
    @size = size
    @policy = detect_policy
  end

  def name
  	self.class.generate_name(@x, @y)
  end

  def to_a
  	[@x, @y]
  end

  def can_move?(direction)
  	@policy.respond_to?(:"#{direction}")
  end

  def self.generate_name(x, y)
  	"#{x}_#{y}"
  end

  private

	def detect_policy
    if ( @x == 0) && ( @y == 0)
      SouthWestCell.new
    elsif (@y == 0) && any?(@x)
      SouthCell.new
    elsif (@x == @size) && ( @y == 0)
      SouthEastCell.new       
    elsif (@x == 0) && any?(@y)
      WestCell.new
    elsif (@x == @size) && any?(@y)
      EastCell.new
    elsif (@x == 0) && (@y == @size)
      NorthWestCell.new
    elsif any?(@x) && (@y == @size)
      NorthCell.new
    elsif (@x == @size) && (@y == @size)
      NorthEastCell.new
    else
      MiddleCell.new
    end
  end

  def any?(number)
    (1...@size).include?(number)
  end

end