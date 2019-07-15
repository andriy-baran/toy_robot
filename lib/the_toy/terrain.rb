module TheToy
  class Terrain
    attr_accessor :mediator

    def initialize(size: 5)
      @size = size
      @cells = {}
      5.times.to_a.product(5.times.to_a).each do |x,y|
        cell = Cell.new(x: x,y: y).extend(cell_type_module(x, y, size))
        @cells[cell.name] = cell
      end
    end

    def [](x,y)
      @cells["#{x}_#{y}"]
    end

    def cell_exists?(x,y)
      !cell_on(x,y).nil?
    end

    def place_object(x,y,facing,obj)
      cell_on(x,y).object = obj
      mediator.placed(x,y,facing)
      # print_map
    end

    def move_object(from,to,obj)
      cell_on(*to).object = cell_on(*from).object
      cell_on(*from).object = nil
      mediator.moved(*to)
      # print_map
    end

    def print_map
      puts
      @cells.values.each_slice(5).to_a.transpose.each do |row|
        puts row.map { |c|
          if c.object.nil?
            :o
          else
            case c.object.send(:facing)
            when :north
              :_
            when :west
              :<
            when :east
              :>
            when :south
              '^'
            end
          end
        }.join
      end
      puts
    end

    private

    alias cell_on []

    def cell_type_module(x, y, size)
      any = proc { |number| (1...size).include?(number) }
      if (x == 0) && (y == 0)
        Landscape[:north, :east]
      elsif (y == 0) && any[x]
        Landscape[:north, :east, :west]
      elsif (x == size) && (y == 0)
        Landscape[:north, :west]
      elsif (x == 0) && any[y]
        Landscape[:north, :south, :east]
      elsif (x == size) && any[y]
        Landscape[:north, :south, :west]
      elsif (x == 0) && (y == size)
        Landscape[:south, :east]
      elsif any[x] && (y == size)
        Landscape[:south, :east, :west]
      elsif (x == size) && (y == size)
        Landscape[:south, :west]
      else
        Landscape[:north, :south, :east, :west]
      end
    end
  end
end
