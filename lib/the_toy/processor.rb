module TheToy
  class Processor
    attr_accessor :mediator
    attr_writer :file

    def run
      @file.each_line do |line|
        parse_and_process(line.chomp)
      end
      # loop do
      #   begin
      #   rescue StopIteration => e
      #     break
      #   end
      # end
    end

    def file
      @file || Tempfile.new
    end

    def execute(command)
      parse_and_process(command)
    end

    private

    def parse_and_process(command)
      if matches = command.match(/PLACE\s+(\d+)\s*\,(\d+)\s*\,([\w]{4,5})/)
        x, y, facing = *matches.captures
        mediator.place(x.to_i, y.to_i, facing.downcase.to_sym)
      elsif command.match(/MOVE/)
        mediator.move
      elsif command.match(/REPORT/)
        mediator.report
      elsif command.match(/LEFT/)
        mediator.left
      elsif command.match(/RIGHT/)
        mediator.right
      end
    end
  end
end
