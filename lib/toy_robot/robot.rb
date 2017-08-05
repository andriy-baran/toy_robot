class Robot
  def initialize(x: 0, y: 0, facing: 'west', size: 5)
    @size = size
    @facing = facing
    @compas = Compass.new(@facing)
    @legs = Legs.new(x: x, y: y, size: @size)
  end

  def left
    @facing = @compas.left
  end

  def right
    @facing = @compas.right
  end

  def move
    @legs.go(@facing)
  end

  def place(x, y, facing)
    @facing = facing.downcase
    @compas.set(@facing)
    @legs.jump(x: x.to_i, y: y.to_i)
  end

  def report
    puts "#{@legs.position.x},#{@legs.position.y},#{@facing.upcase}"
  end
end
