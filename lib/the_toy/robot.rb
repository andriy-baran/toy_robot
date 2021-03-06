module TheToy
  class Robot
    extend Forwardable

    def_delegators :@head, :current_coordinates, :facing
    def_delegators :@processor, :execute

    attr_accessor :mediator

    def initialize(name = 'Anonim', processor: Processor.new)
      @name = name
      @head = Head.new(:west, x: nil, y: nil)
      @processor = processor
      @processor.mediator = Medium.new.tap do |m|
        m.on_place = ->(x,y,facing) { self.send(:place,x,y,facing) }
        m.on_move = -> { self.send(:move) }
        m.on_left = -> { self.send(:left) }
        m.on_right = -> { self.send(:right) }
        m.on_report = -> { self.send(:report) }
      end
    end

    def update_coordinates(x,y)
      @head.x = x
      @head.y = y
    end

    def update_facing(facing)
      @head.set(facing)
    end

    def scenario=(file)
      @processor.file = file
    end

    def execute_scenario
      @processor.run
    end

    def placed?
      @head.has_coordinates?
    end

    private

    def left
      @head.left
    end

    def right
      @head.right
    end

    def move
      return unless placed?
      mediator.move(@head.current_coordinates,@head.facing,self)
    end

    def place(x,y,facing)
      return unless %i(north east south west).include?(facing)
      cell_exists = mediator.scan(x,y)
      mediator.place(x,y,facing,self) if cell_exists
    end

    def report
      puts @head.report_position
    end
  end
end
