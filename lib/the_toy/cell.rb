module TheToy
  class Cell
    attr_accessor :object
    attr_reader :x, :y

    def initialize(x:, y:)
      @x, @y  = x, y
      @object = nil
    end

    def name
      "#{x}_#{y}"
    end
  end
end
