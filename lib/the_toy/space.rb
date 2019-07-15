module TheToy
  class Space
    def initialize
      @terrain = Terrain.new
      @robot = Robot.new
      @terrain.mediator = Medium.new.tap do |m|
        m.when_placed = ->(x,y,facing) do
          @robot.update_coordinates(x,y)
          @robot.update_facing(facing)
        end
        m.when_moved = ->(x,y) { @robot.update_coordinates(x,y) }
      end
      @robot.mediator = Medium.new.tap do |m|
        m.on_scan = ->(x,y) { @terrain.cell_exists?(x,y) }
        m.on_place = ->(x,y,facing,obj) do
          @terrain[*obj.current_coordinates].object = nil if obj.placed?
          @terrain.place_object(x,y,facing,obj)
        end
        m.on_move = ->(from,direction,obj) do
          break unless @terrain[*from].respond_to?(direction)
          to = calculate_next_coordinates(from,direction)
          @terrain.move_object(from,to,obj)
        end
      end
    end

    def start_time
      @robot.execute_scenario
    end

    private

    def calculate_next_coordinates(from,direction)
      send(direction, *from)
    end

    def north(x,y)
      [x, y + 1]
    end

    def west(x,y)
      [x - 1, y]
    end

    def south(x,y)
      [x, y - 1]
    end

    def east(x,y)
      [x + 1, y]
    end
  end
end
