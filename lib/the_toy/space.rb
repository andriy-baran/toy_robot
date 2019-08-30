module TheToy
  class Space
    extend Forwardable

    def_delegators :@terrain, :print_map, :cells_pictograms

    def initialize(terrain = Terrain.new)
      @terrain = terrain
      @agents = []
    end

    def add_agent(agent)
      @agents << agent
      sync(agent)
    end

    def start_time_async
      threads = []
      @agents.each do |agent|
        threads << Thread.new { agent.execute_scenario }
      end
      threads.each(&:join)
    end

    def start_time
      @agents.each do |agent|
        agent.execute_scenario
      end
    end

    def sync(agent)
      @terrain.mediators[agent.object_id] = Medium.new.tap do |m|
        m.when_placed = ->(x,y,facing) do
          agent.update_coordinates(x,y)
          agent.update_facing(facing)
        end
        m.when_moved = ->(x,y) { agent.update_coordinates(x,y) }
      end
      agent.mediator = Medium.new.tap do |m|
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
