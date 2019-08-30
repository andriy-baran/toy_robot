module TheToy
  class Terrain
    attr_accessor :mediators

    def initialize(size: 5)
      @size = size
      @cells = {}
      @mediators = {}
      5.times.to_a.product(5.times.to_a).each do |x,y|
        cell = Cell.new(x: x,y: y).extend(cell_type_module(x, y, size - 1))
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
      return if cell_on(x,y) && !cell_on(x,y).object.nil?
      cell_on(x,y).object = obj
      mediators[obj.object_id].placed(x,y,facing)
      # print_map
    end

    def move_object(from,to,obj)
      return if cell_on(*to) && !cell_on(*to).object.nil?
      cell_on(*to).object = cell_on(*from).object
      cell_on(*from).object = nil
      mediators[obj.object_id].moved(*to)
      # print_map
    end

    def print_map
      puts
      cells_pictograms.each{ |row| puts row }
      puts
    end

    def cells_pictograms
      @cells.values.each_slice(5).to_a.transpose.map do |row|
        row.map { |c|
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
