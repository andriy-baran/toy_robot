module TheToy
  class Head
    attr_accessor :x, :y, :facing

    def initialize(facing, x: nil, y: nil)
      @x, @y = x, y
      @ways = %i(north east south west)
      set(facing)
    end

    def left
      @facing = rotate_left.first
    end

    def right
      @facing = rotate_right.first
    end

    def set(facing)
      rotate_left while @ways.first != facing
      @facing = @ways.first
    end

    def current_coordinates
      [@x, @y]
    end

    def has_coordinates?
      !@x.nil? && !@y.nil?
    end

    def report_position
      "#{@x},#{@y},#{@facing.upcase}"
    end

    private

    def rotate_right
      @ways.unshift(@ways.pop)
    end

    def rotate_left
      @ways.push(@ways.shift)
    end
  end
end
